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
