SELECT first_name, ensemble_teacher, street_name
FROM person, instructor, address
WHERE person.id = instructor.person_id
  AND address_id=address.id;


SELECT DISTINCT lesson_pricing.type AS "Lesson type", lesson_pricing.level AS "Lesson level",
       lesson.place AS "Classroom", schedule_time.date AS "Day", schedule_time.time AS "Time",
       person.first_name AS "Teacher", instrument_type.name AS "Instrument", ensemble_lesson.genre AS Genre
FROM lesson_pricing, lesson, schedule_time, person, instrument_type,
     ensemble_lesson, individual_lesson, group_lesson
WHERE lesson_pricing.id=lesson.lesson_pricing_id AND
      schedule_time.id=lesson.schedule_time_id AND
      person.id = schedule_time.instructor_id AND
      --lesson.id = group_lesson.lesson_id AND
      (instrument_type.id = group_lesson.instrument_type_id OR group_lesson.instrument_type_id = instrument_type.id OR ensemble_lesson.lesson_id = lesson.id)
;

SELECT person_id, student_id_1, student_id_2 FROM student, sibling_relation
WHERE student.person_id = sibling_relation.student_id_1 OR student.person_id = sibling_relation.student_id_2;

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
          ORDER BY student.person_id
          ) AS subquery
GROUP BY No_Of_Siblings
ORDER BY No_Of_Siblings
;


SELECT student.person_id, COUNT(*) AS No_Of_Siblings
FROM student, sibling_relation
WHERE student.person_id = sibling_relation.student_id_1 OR student.person_id = sibling_relation.student_id_2
GROUP BY student.person_id
ORDER BY student.person_id
;

select *
from student full join person on student.person_id = person.id