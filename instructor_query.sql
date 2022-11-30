SELECT instructor_lesson.person_id, 
    CONCAT(instructor_lesson.first_name, ' ', instructor_lesson.last_name) AS Name, 
    COUNT(*) AS amount
    FROM 
    (
        (
            (
            lesson LEFT JOIN schedule_time
            ON lesson.schedule_time_id = schedule_time.id
            )
        LEFT JOIN instructor ON schedule_time.instructor_id = instructor.person_id
        )
    LEFT JOIN person ON instructor.person_id = person.id
    ) AS instructor_lesson
    
    GROUP BY (instructor_lesson.person_id, instructor_lesson.first_name, instructor_lesson.last_name, instructor_lesson.date)
    
    HAVING EXISTS
    (SELECT * FROM schedule_time 
    WHERE DATE_PART('month', instructor_lesson.date) = DATE_PART('month', CURRENT_DATE)
    AND DATE_PART('year', instructor_lesson.date) = DATE_PART('year', CURRENT_DATE))

    ORDER BY Name;
