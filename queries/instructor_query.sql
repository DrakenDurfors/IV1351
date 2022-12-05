/*TASK: List all instructors who has given more than a specific number of lessons during the current month.
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