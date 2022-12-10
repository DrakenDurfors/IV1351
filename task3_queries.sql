/* IV1351 Data Storage Paradigms
   Seminar 3/Task 3
   Soundgood Music School
   @Author Albin Durfors, Tove Verner-Carlsson
   @Date 2022-12-05
   */

/*
Show the number of lessons given per month during a specified year. This query is expected to be performed a few times per week.
It shall be possible to retrieve the total number of lessons per month (just one number per month)
and the specific number of individual lessons, group lessons and ensembles (three numbers per month).
It's not required that all four numbers (total plus one per lesson type) for a particular month are on the same row;
you're allowed to have one row for each number as long as it's clear to which month each number belongs.
However, it's most likely easier to understand the result if you do place all numbers for a particular month on the same row,
and it's an interesting exercise, therefore you're encouraged to try.*/

EXPLAIN ANALYZE
SELECT TO_CHAR(TO_DATE(DATE_PART('month', a.date)::text, 'MM'), 'mon') AS month,
       COUNT(DATE_PART('month', a.date))                               AS lessons,
       SUM(CASE WHEN a.type = 'individual' then 1 else 0 end)          AS individual,
       SUM(CASE WHEN a.type = 'Ensemble' then 1 else 0 end)            AS ensemble,
       SUM(CASE WHEN a.type = 'Group' then 1 else 0 end)               AS "group"
FROM ((lesson LEFT JOIN schedule_time ON schedule_time.id = lesson.schedule_time_id)
    LEFT JOIN lesson_pricing ON lesson_pricing.id = lesson.lesson_pricing_id) AS a
GROUP BY DATE_PART('year', a.date), DATE_PART('month', a.date)
HAVING DATE_PART('year', a.date) = '2022'   --this year can be changed
;

/*Show how many students there are with no sibling, with one sibling, with two siblings, etc.
This query is expected to be performed a few times per week. The database must contain students with no sibling,
one sibling and two siblings, but doesn't have to contain students with more than two siblings.
Note that it's not allowed to solve this by just adding a column with sibling count (maybe called no_of_siblings or something similar)
to the student table. Such a solution would be almost impossible to maintain since it doesn't tell who's a sibling of who.
If a student quits, there wont be any way to update the sibling count of that student's siblings.*/
EXPLAIN ANALYZE
SELECT No_Of_Siblings, COUNT(*) AS No_Of_Students
FROM (SELECT student.person_id, COALESCE(sibling_table.No_Of_Siblings, 0) AS No_Of_Siblings
      FROM student
               LEFT JOIN
           (SELECT student.person_id, COUNT(*) AS No_Of_Siblings
            FROM student,
                 sibling_relation
            WHERE student.person_id = sibling_relation.student_id_1
               OR student.person_id = sibling_relation.student_id_2
            GROUP BY student.person_id
            ORDER BY student.person_id) AS sibling_table
           ON student.person_id = sibling_table.person_id
      ORDER BY student.person_id) AS subquery
GROUP BY No_Of_Siblings
ORDER BY No_Of_Siblings
;

/*List all instructors who has given more than a specific number of lessons during the current month.
Sum all lessons, independent of type, and sort the result by the number of given lessons.
This query will be used to find instructors risking to work too much, and will be executed daily.*/
EXPLAIN ANALYZE
SELECT instructor_id, first_name, last_name, No_Of_Lessons
FROM person,
     (SELECT date_part('month', schedule_time.date) AS manad, instructor_id, COUNT(*) AS No_Of_Lessons
      FROM lesson,
           schedule_time
      WHERE lesson.schedule_time_id = schedule_time.id
        AND date_part('month', now()) = date_part('month', schedule_time.date) --only show current month
        AND date_part('year', now()) = date_part('year', schedule_time.date)   --only show current month
      GROUP BY manad, instructor_id) AS current_month_lessons
WHERE person.id = current_month_lessons.instructor_id
  AND No_Of_Lessons >= 1 --this constant can be changed
ORDER BY No_Of_Lessons DESC, last_name
;

/*List all ensembles held during the next week, sorted by music genre and weekday.
For each ensemble tell whether it's full booked, has 1-2 seats left or has more seats left.
Hint: you might want to use a CASE statement in your query to produce the desired output.
*/
EXPLAIN ANALYZE
SELECT
    TO_CHAR(date(ensembles.date), 'Dy') AS Day,
    ensembles.genre,
    CASE
        WHEN (ensembles.max_num_students - (SELECT COUNT(*) FROM booking WHERE lesson_id = ensembles.lesson_id) <= 0) then 'no more seats'
        WHEN (ensembles.max_num_students - (SELECT COUNT(*) FROM booking WHERE lesson_id = ensembles.lesson_id) <= 2) then '1 or 2 more seats'
        WHEN (ensembles.max_num_students > (SELECT COUNT(*) FROM booking WHERE lesson_id = ensembles.lesson_id)) then 'plenty of seats' end
    AS spots
FROM
    ((lesson INNER JOIN ensemble_lesson ON lesson.id = ensemble_lesson.lesson_id)
    LEFT JOIN schedule_time ON lesson.schedule_time_id = schedule_time.id) AS ensembles
WHERE
    DATE_PART('week', ensembles.date) = (DATE_PART('week', NOW()) + 1)
AND
    DATE_PART('year', ensembles.date) = DATE_PART('year', NOW())
ORDER BY (ensembles.date, ensembles.genre);