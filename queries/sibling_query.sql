/*TASK: Show how many students there are with no sibling, with one sibling, with two siblings, etc. */
/*Sibling query*/
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