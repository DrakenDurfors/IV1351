-- Show number of lessons given a specified year


-- V.1 Show only number of lessons per month for a given year
SELECT TO_CHAR(TO_DATE(DATE_PART('month', a.date)::text, 'MM'), 'mon') AS month, COUNT(DATE_PART('month', a.date)) AS lesson_amount 
    FROM
        (lesson LEFT JOIN schedule_time ON schedule_time.id = lesson.schedule_time_id) AS a
        GROUP BY (DATE_PART('year', a.date), DATE_PART('month', a.date)) 
        HAVING DATE_PART('year', a.date) = '2022';

-- V.2 Show number of every type of lesson per month for a given year (multiple rows)
SELECT TO_CHAR(TO_DATE(DATE_PART('month', a.date)::text, 'MM'), 'mon') AS month, 
    COUNT(DATE_PART('month', a.date)) AS lessons,
    a.type AS type
    FROM
        ((lesson LEFT JOIN schedule_time ON schedule_time.id = lesson.schedule_time_id)
        LEFT JOIN lesson_pricing ON lesson_pricing.id = lesson.lesson_pricing_id) AS a
        GROUP BY (DATE_PART('year', a.date), DATE_PART('month', a.date), a.type) 
        HAVING DATE_PART('year', a.date) = '2022';

-- V.2 Show number of every type of lesson per month for a given year (one row)
SELECT TO_CHAR(TO_DATE(DATE_PART('month', a.date)::text, 'MM'), 'mon') AS month, 
    COUNT(DATE_PART('month', a.date)) AS lessons,
    SUM(CASE WHEN a.type = 'individual' then 1 else 0 end) AS individual,
    SUM(CASE WHEN a.type = 'Ensemble' then 1 else 0 end) AS Ensemble,
    SUM(CASE WHEN a.type = 'Group' then 1 else 0 end) AS Group

    FROM
        ((lesson LEFT JOIN schedule_time ON schedule_time.id = lesson.schedule_time_id)
        LEFT JOIN lesson_pricing ON lesson_pricing.id = lesson.lesson_pricing_id) AS a
        GROUP BY (DATE_PART('year', a.date), DATE_PART('month', a.date)) 
        HAVING DATE_PART('year', a.date) = '2022';
