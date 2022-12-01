SELECT first_name, ensemble_teacher, street_name
FROM person,
     instructor,
     address
WHERE person.id = instructor.person_id
  AND address_id = address.id;

SELECT *
FROM ADDRESS;

SELECT DISTINCT lesson_pricing.type   AS "Lesson type",
                lesson_pricing.level  AS "Lesson level",
                lesson.place          AS "Classroom",
                schedule_time.date    AS "Day",
                schedule_time.time    AS "Time",
                person.first_name     AS "Teacher",
                instrument_type.name  AS "Instrument",
                ensemble_lesson.genre AS Genre
FROM lesson_pricing,
     lesson,
     schedule_time,
     person,
     instrument_type,
     ensemble_lesson,
     individual_lesson,
     group_lesson
WHERE lesson_pricing.id = lesson.lesson_pricing_id
  AND schedule_time.id = lesson.schedule_time_id
  AND person.id = schedule_time.instructor_id
  AND
  --lesson.id = group_lesson.lesson_id AND
    (instrument_type.id = group_lesson.instrument_type_id OR group_lesson.instrument_type_id = instrument_type.id OR
     ensemble_lesson.lesson_id = lesson.id)
;

SELECT person_id, student_id_1, student_id_2
FROM student,
     sibling_relation
WHERE student.person_id = sibling_relation.student_id_1
   OR student.person_id = sibling_relation.student_id_2;

SELECT No_Of_Siblings, COUNT(*) AS No_Of_Students
FROM (SELECT student.person_id, COALESCE(sibling_table.No_Of_Siblings, 0) AS No_Of_Siblings
      FROM student
               FULL JOIN
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


SELECT student.person_id, COUNT(*) AS No_Of_Siblings
FROM student,
     sibling_relation
WHERE student.person_id = sibling_relation.student_id_1
   OR student.person_id = sibling_relation.student_id_2
GROUP BY student.person_id
ORDER BY student.person_id
;

SELECT instructor_id, first_name, last_name, COUNT(*) AS No_Of_Lessons
FROM person,
     (SELECT date_part('month', schedule_time.date) AS manad, instructor_id
      FROM lesson,
           schedule_time
      WHERE lesson.schedule_time_id = schedule_time.id
        --AND date_part('month', schedule_time.date) = 11
        AND date_part('month', now()) = date_part('month', schedule_time.date)
        AND date_part('year', now()) = date_part('year', schedule_time.date)) AS current_month_lessons
WHERE person.id = current_month_lessons.instructor_id
GROUP BY instructor_id, first_name, last_name
ORDER BY No_Of_Lessons DESC, last_name
;

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
list ensembles*/
SELECT ensemble_lesson.lesson_id, genre, schedule_time.date,
       count(*) AS No_Of_Bookings, max_num_students,
       (ensemble_lesson.max_num_students - count(*)) AS places_left
FROM ensemble_lesson,
     lesson,
     schedule_time,
     booking
WHERE ensemble_lesson.lesson_id = lesson.id
  AND lesson.schedule_time_id = schedule_time.id
  AND booking.lesson_id = lesson.id
GROUP BY ensemble_lesson.lesson_id, genre, date
;

























