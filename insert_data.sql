
INSERT INTO address (postal_code, street_name, street_number)
VALUES
    ('11212','Grimauld Place','12'),
    ('20010','The Burrow','1'),
    ('34444','Privet Drive','4'),
    ('43377','Hogwarts','77'),
    ('55555','Patil Residence','11'),
    ('66666','Malfoys Manor','1'),
    ('77777','Grandmother Street','17'),
    ('88888', 'Indian Garden', '99');


INSERT INTO person (ssn,first_name,last_name,address_id,phone_no,email)
VALUES
    ('195911031337', 'Sirius', 'Black', 1,'0803331100', 'padfoot@gmail.com'),
    ('198003015555','Ron','Weasley',2,'0735554444','theweasel@hotmail.com'),
    ('198108118888','Ginny','Weasley',2,'0737778888','badass_babe@gmail.com'),
    ('198007317777','Harry','Potter',3,'0776669999','draco_lover@yahoo.com'),
    ('194910301234','Molly','Weasley',2,'0737778888',NULL),

    ('193510041111','Minerva','McGonagall',4,'073777449','gogryffindor@gmail.com'),
    ('196001096666','Severus','Snape',3,'0766666666','sectumsempra@gmail.com'),
    ('197608221111', 'Percy', 'Weasley', 2, '071234567', 'ministry_simp@hotmail.com'),
    ('198007302222', 'Neville', 'Longbottom', 7, '0736665055', 'iforgotmypassword@yahoo.com'),
    ('197911053333', 'Padma', 'Patil',8,'0709801532', 'bunny123@gmail.com'),

    ('197911053334', 'Parvati', 'Patil', 8, '0709801327', 'bunny456@gmail.com'),
    ('194612121212', 'Augusta', 'Longbottom', 7, NULL, 'plzsendowlinstead@confused.co.uk'),
    ('188108261111','Albus','Dumbledore',4,'073772141','tenpointstogriffindor@gmail.com'),
    ('196303096666','Sybill','Trelawney',4,'0766663422','yourfateissealed@gmail.com'),
    ('197605151111', 'Pomona', 'Sprout', 4, '071231123', 'plantsarenice@plants.com'),

    ('189003282222', 'Horace', 'Slughorn', 7, '0736669802', 'slug@yahoo.com'),
    ('196401263333', 'Gilderoy', 'Lockhart',4,'0709804423', 'narcissus@gmail.com')
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
    ('ITK', 200, 1),
    ('ITK', 300, 1),
    ('ITK', 300, 1),
    ('Qmisk', 150, 1),
    ('Tmeit', 250, 2),
    ('Tmeit', 250, 2),
    ('Tmeit', 200, 2),
    ('ITK', 320, 3),
    ('ITK', 320, 3),
    ('Qmisk', 280, 3),
    ('Qmisk', 280, 3),
    ('Qmisk', 280, 3),
    ('Qmisk', 630, 4),
    ('Tmeit', 200, 4),
    ('Tmeit', 200, 4),
    ('Tmeit', 200, 4),
    ('ITK', 500, 5),
    ('ITK', 550, 5),
    ('Fender', 700, 1),
    ('Fender', 700, 1),
    ('Fender', 700, 1)
    ;

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
    (4, 1),
    (8, 5),
    (9, 12),
    (10,6),
    (11,6)
    ;

INSERT INTO sibling_relation (student_id_1, student_id_2)
    VALUES
        (2,3),
        (2,8),
        (3,8),
        (10,11)
        ;

INSERT INTO instructor (person_id, ensemble_teacher)
VALUES
    (6, 'No'),
    (7, 'Yes'),     --Snape
    (13, 'Yes'),    --Dumbledore
    (14, 'No'),
    (15, 'Yes'),    --Sprout
    (16, 'No'),
    (17, 'No');

INSERT INTO instructor_proficiencies (instructor_id, instrument_id)
VALUES
    (6, 1),
    (6, 3),
    (6, 5),
    (7, 1),
    (7, 2),
    (7, 4),
    (13, 1),
    (13, 2),
    (13, 4),
    (14, 3),
    (14, 2),
    (15, 3),
    (15, 1),
    (15, 5),
    (17, 4);

INSERT INTO instrument_lease (lease_start, student_id, instruments_id)
VALUES
    ('2022-11-30', 2, 6),
    ('2022-10-05', 3, 10),
    ('2022-09-20', 2, 1),
    ('2022-08-17', 4, 5);

INSERT INTO schedule_time (time, date, instructor_id)
VALUES
    ('10:00', '2022-11-30', 6),
    ('13:00', '2022-11-30', 13),
    ('15:00', '2022-11-30', 15),
    ('09:00', '2022-12-01', 17),
    ('10:00', '2022-12-02', 6),

    ('10:00', '2022-12-02', 7),
    ('10:00', '2022-10-02', 13),
    ('13:00', '2022-10-08', 15),
    ('15:00', '2022-10-25', 17),
    ('10:00', '2021-11-30', 6),

    ('13:00', '2021-11-30', 13),
    ('15:00', '2021-11-30', 15),
    ('09:00', '2021-12-01', 16),
    ('10:00', '2021-12-02', 6),
    ('10:00', '2021-12-02', 7),

    ('10:00', '2021-10-02', 13),
    ('13:00', '2021-10-08', 16),
    ('15:00', '2021-10-25', 17),
    ('10:00', '2022-12-08', 13),
    ('12:00', '2022-12-08', 13),

    ('12:00', '2022-12-09', 13),
    ('16:00', '2022-12-12', 13),
    ('10:00', '2022-12-13', 15),
    ('12:00', '2022-12-13', 15),
    ('12:00', '2022-12-15', 15),
    ('16:00', '2022-12-15', 15)
    ;
    

INSERT INTO lesson (lesson_pricing_id, place, schedule_time_id)
VALUES
    (1,'Ka-301', 1), --individual, beginner, instructor 6
    (1,'Ka-301', 3), --individual, beginner, instructor 6
    (4,'Ka-303', 2), --group, beginner, instructor 7
    (4,'Ka-301', 4), --group, beginner, instructor 7
    (8,'Ka-303', 6), --ensemble, intermediate, instructor 7

    (1,'Ka-301', 14), --individual, beginner, instructor 6
    (1,'Ka-301', 7), --individual, beginner, instructor 13
    (4,'Ka-303', 13), --group, beginner, instructor 16
    (4,'Ka-301', 16), --group, beginner, instructor 13
    (8,'Ka-303', 12), --ensemble, intermediate, instructor 15

    (7, 'The Great Hall', 19),  --instr13
    (9, 'Ka-208', 20),          --instr13
    (7, 'The Great Hall', 21),  --instr13
    (9, 'Ka-205', 22),          --instr13
    (7, 'The Great Hall', 23),  --instr15
    (9, 'Ka-208', 24), --instr15
    (8, 'Ka-301', 25), --instr15
    (8, 'Ka-301', 26)  --instr15
;

INSERT INTO individual_lesson (lesson_id, instrument_type_id)
VALUES
    (1, 1), --instructor 6, guitar
    (2, 3), --instructor 6, piano
    (6, 5), --instructor 6, harp
    (7, 2); --instructor 13, piano

INSERT INTO group_lesson (lesson_id, max_num_students, min_num_students, instrument_type_id)
VALUES
    (3,15,2,2), --flute
    (4,15,2,2), --flute
    (8,20,3,1), --guitar
    (9,10,2,4); --drums


INSERT INTO ensemble_lesson (lesson_id, max_num_students, min_num_students, genre)
VALUES
    (5,20,2,'Heavy Metal'),
    (10,16,3,'Pop'),
    (11, 2, 1, 'Punk'),
    (12, 2, 1, 'Rock'),
    (13, 1, 1, 'Jazz'),
    (14, 10, 1, 'Ghost'),
    (15, 1, 1, 'Choir'),
    (16, 10, 1, 'Ghost'),
    (17, 1, 1, 'Choir'),
    (18, 2, 1, 'Rock')
    ;

INSERT INTO booking (student_id, lesson_id, time_of_booking)
VALUES
    (2,1,now()),
    (3,2,now()),
    (3,3,now()),
    (4,3,now()),
    (3,4,now()),

    (4,4,now()),
    (2,5,now()),
    (3,5,now()),
    (2,6,now()),
    (3,7,now()),

    (3,8,now()),
    (4,8,now()),
    (3,9,now()),
    (4,9,now()),
    (2,10,now()),
    (3,10,now()),

    (11, 13, now()),
    (9, 15, now()),
    (10, 17,now())
    ;