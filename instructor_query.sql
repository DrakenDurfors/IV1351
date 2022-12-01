/*TASK: List all instructors who has given more than a specific number of lessons during the current month.
  Sum all lessons, independent of type, and sort the result by the number of given lessons.
  This query will be used to find instructors risking to work too much, and will be executed daily.*/


/*Albin version*/
SELECT instructor_lesson.person_id,
       CONCAT(instructor_lesson.first_name, ' ', instructor_lesson.last_name) AS Name,
       COUNT(*)                                                               AS amount
FROM (((lesson LEFT JOIN schedule_time ON lesson.schedule_time_id = schedule_time.id)
    LEFT JOIN instructor ON schedule_time.instructor_id = instructor.person_id) LEFT JOIN person
      ON instructor.person_id = person.id) AS instructor_lesson
GROUP BY instructor_lesson.person_id, instructor_lesson.first_name, instructor_lesson.last_name,
         instructor_lesson.date
HAVING EXISTS
    (SELECT *
     FROM schedule_time
     WHERE DATE_PART('month', instructor_lesson.date) = DATE_PART('month', CURRENT_DATE)
       AND DATE_PART('year', instructor_lesson.date) = DATE_PART('year', CURRENT_DATE))
   AND COUNT(instructor_lesson.person_id) >= 1
ORDER BY Name;


/*Tove version*/
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