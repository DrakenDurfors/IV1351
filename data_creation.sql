INSERT INTO address (postal_code, street_name, street_number)
VALUES
    ('11212','Grimauld Place','12'),
    ('10010','The Burrow','1'),
    ('14444','Privet Drive','4'),
    ('13377','Hogwarts','77');

INSERT INTO person (ssn,first_name,last_name,address_id,phone_no,email)
VALUES
    ('195911031337', 'Sirius', 'Black', 1,'0803331100', 'padfoot@gmail.com'),
    ('198003015555','Ron','Weasley',2,'0735554444','theweasel@hotmail.com'),
    ('198108118888','Ginny','Weasley',2,'0737778888','badass_babe@gmail.com'),
    ('198007312222','Harry','Potter',3,'0776669999','draco_lover@yahoo.com'),
    ('194910301234','Molly','Weasley',2,'0737778888',NULL),
    ('193510041111','Minerva','McGonagall',4,'073777449','gogryffindor@gmail.com'),
    ('196001096666','Severus','Snape',3,'0766666666','sectumsempra@gmail.com')
    ;


INSERT INTO instrument_type (name)
VALUES
    ('Guitar'),
    ('Flute'),
    ('Piano'),
    ('Drums'),
    ('Harp');


INSERT INTO instruments (brand, fee, instrument_type_id)
VALUES
    ('ITK', 200, 1),
    ('ITK', 300, 1),
    ('Qmisk', 150, 1),
    ('Tmeit', 250, 2),
    ('Tmeit', 200, 2),
    ('ITK', 320, 3),
    ('Qmisk', 280, 3),
    ('Qmisk', 630, 4),
    ('Tmeit', 200, 4),
    ('ITK', 500, 5),
    ('ITK', 550, 5);

INSERT INTO lesson_pricing (type, level, price, discount)
VALUES
    ('individual','beginner',350, 10),
    ('individual','intermediate',350, 10),
    ('individual','advanced',450, 10),
    ('Group','beginner',300, 5),
    ('Group','intermediate',300, 5),
    ('Group','advanced',400, 5),
    ('Ensemble','beginner',250, 15),
    ('Ensemble','intermediate',250, 15),
    ('Ensemble','advanced',350, 15);

INSERT INTO student (person_id, contact_id)
VALUES
    (2, 5),
    (3, 5),
    (4,1);

INSERT INTO sibling_relation (student_id_1, student_id_2)
    VALUES (2,3);

INSERT INTO instructor (person_id, ensemble_teacher)
VALUES
    (6, 'Yes'),
    (7, 'No');

INSERT INTO instructor_proficiencies (instructor_id, instrument_id)
VALUES
    (6, 1),
    (6, 3),
    (6, 5),
    (7, 1),
    (7, 2),
    (7, 4);

INSERT INTO schedule_time (time, date, instructor_id)
VALUES
    ('10:00', '2022-11-30', 6),
    ('13:00', '2022-11-30', 7),
    ('15:00', '2022-11-30', 6),
    ('09:00', '2022-12-01', 7),
    ('10:00', '2022-12-02', 6),
    ('10:00', '2022-12-02', 7);

INSERT INTO lesson (lesson_pricing_id, place, schedule_time_id)
VALUES
    (1,'Ka-301', 1), --individual, beginner, instructor 6
    (1,'Ka-301', 3), --individual, beginner, instructor 6
    (4,'Ka-303', 2), --group, beginner, instructor 7
    (4,'Ka-301', 4), --group, beginner, instructor 7
    (8,'Ka-303', 6); --ensemble, advanced, instructor 7

INSERT INTO ensemble_lesson (lesson_id, max_num_students, min_num_students, genre)
VALUES
    (5,20,2,'Heavy Metal');

INSERT INTO individual_lesson (lesson_id, instrument_type_id)
VALUES
    (1, 1), --instructor 6, guitar
    (2, 3); --instructor 6, piano

INSERT INTO group_lesson (lesson_id, max_num_students, min_num_students, instrument_type_id)
VALUES
    (3,15,2,2), --flute
    (4,15,2,2); --flute

INSERT INTO booking (student_id, lesson_id, time_of_booking)
VALUES
    (2,1,now()),
    (3,2,now()),
    (3,3,now()),
    (4,3,now()),
    (3,4,now()),
    (4,4,now()),
    (2,5,now()),
    (3,5,now());