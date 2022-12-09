CREATE TABLE address (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 postal_code CHAR(5) NOT NULL,
 street_name VARCHAR(50) NOT NULL,
 street_number VARCHAR(4) NOT NULL
);

ALTER TABLE address ADD CONSTRAINT PK_address PRIMARY KEY (id);


CREATE TABLE instrument_type (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 name VARCHAR(50) NOT NULL
);

ALTER TABLE instrument_type ADD CONSTRAINT PK_instrument_type PRIMARY KEY (id);


CREATE TABLE instruments (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 brand VARCHAR(50) NOT NULL,
 fee DECIMAL NOT NULL,
 instrument_type_id INT NOT NULL
);

ALTER TABLE instruments ADD CONSTRAINT PK_instruments PRIMARY KEY (id);


CREATE TABLE lesson_pricing (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 type VARCHAR(20) NOT NULL,
 level VARCHAR(20) NOT NULL,
 price DECIMAL(10) NOT NULL,
 discount DECIMAL(5) NOT NULL
);

ALTER TABLE lesson_pricing ADD CONSTRAINT PK_lesson_pricing PRIMARY KEY (id);


CREATE TABLE person (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 ssn VARCHAR(12) UNIQUE NOT NULL,
 first_name VARCHAR(50) NOT NULL,
 last_name VARCHAR(50) NOT NULL,
 address_id INT NOT NULL,
 phone_no VARCHAR(20),
 email VARCHAR(50)
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (id);


CREATE TABLE student (
 person_id INT NOT NULL,
 contact_id INT
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (person_id);


CREATE TABLE instructor (
 person_id INT NOT NULL,
 ensemble_teacher BOOLEAN NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (person_id);


CREATE TABLE instructor_proficiencies (
 instructor_id INT NOT NULL,
 instrument_id INT NOT NULL
);

ALTER TABLE instructor_proficiencies ADD CONSTRAINT PK_instructor_proficiencies PRIMARY KEY (instructor_id,instrument_id);


CREATE TABLE instrument_lease (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 lease_start DATE NOT NULL,
 lease_end DATE,
 student_id INT NOT NULL,
 instruments_id INT NOT NULL
);

ALTER TABLE instrument_lease ADD CONSTRAINT PK_instrument_lease PRIMARY KEY (id);


CREATE TABLE schedule_time (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 time TIME NOT NULL,
 date DATE NOT NULL,
 instructor_id INT NOT NULL
);

ALTER TABLE schedule_time ADD CONSTRAINT PK_schedule_time PRIMARY KEY (id);


CREATE TABLE sibling_relation (
 student_id_1 INT NOT NULL,
 student_id_2 INT NOT NULL
);

ALTER TABLE sibling_relation ADD CONSTRAINT PK_sibling_relation PRIMARY KEY (student_id_1,student_id_2);


CREATE TABLE lesson (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 lesson_pricing_id INT NOT NULL,
 place VARCHAR(50) NOT NULL,
 schedule_time_id INT NOT NULL
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (id);


CREATE TABLE booking (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 student_id INT NOT NULL,
 lesson_id INT,
 time_of_booking TIMESTAMP NOT NULL
);

ALTER TABLE booking ADD CONSTRAINT PK_booking PRIMARY KEY (id);


CREATE TABLE ensemble_lesson (
 lesson_id INT NOT NULL,
 max_num_students INT NOT NULL,
 min_num_students INT NOT NULL,
 genre VARCHAR(50) NOT NULL
);

ALTER TABLE ensemble_lesson ADD CONSTRAINT PK_ensemble_lesson PRIMARY KEY (lesson_id);


CREATE TABLE group_lesson (
 lesson_id INT NOT NULL,
 max_num_students INT NOT NULL,
 min_num_students INT NOT NULL,
 instrument_type_id INT NOT NULL
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (lesson_id);


CREATE TABLE individual_lesson (
 lesson_id INT NOT NULL,
 instrument_type_id INT NOT NULL
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (lesson_id);


ALTER TABLE instruments ADD CONSTRAINT FK_instruments_0 FOREIGN KEY (instrument_type_id) REFERENCES instrument_type (id);


ALTER TABLE person ADD CONSTRAINT FK_person_0 FOREIGN KEY (address_id) REFERENCES address (id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (id);
ALTER TABLE student ADD CONSTRAINT FK_student_1 FOREIGN KEY (contact_id) REFERENCES person (id) ON DELETE SET NULL;


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE instructor_proficiencies ADD CONSTRAINT FK_instructor_proficiencies_0 FOREIGN KEY (instructor_id) REFERENCES instructor (person_id);
ALTER TABLE instructor_proficiencies ADD CONSTRAINT FK_instructor_proficiencies_1 FOREIGN KEY (instrument_id) REFERENCES instrument_type (id);


ALTER TABLE instrument_lease ADD CONSTRAINT FK_instrument_lease_0 FOREIGN KEY (student_id) REFERENCES student (person_id);
ALTER TABLE instrument_lease ADD CONSTRAINT FK_instrument_lease_1 FOREIGN KEY (instruments_id) REFERENCES instruments (id);


ALTER TABLE schedule_time ADD CONSTRAINT FK_schedule_time_0 FOREIGN KEY (instructor_id) REFERENCES instructor (person_id);


ALTER TABLE sibling_relation ADD CONSTRAINT FK_sibling_relation_0 FOREIGN KEY (student_id_1) REFERENCES student (person_id) ON DELETE CASCADE;
ALTER TABLE sibling_relation ADD CONSTRAINT FK_sibling_relation_1 FOREIGN KEY (student_id_2) REFERENCES student (person_id) ON DELETE CASCADE;


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (lesson_pricing_id) REFERENCES lesson_pricing (id);
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_1 FOREIGN KEY (schedule_time_id) REFERENCES schedule_time (id);


ALTER TABLE booking ADD CONSTRAINT FK_booking_0 FOREIGN KEY (student_id) REFERENCES student (person_id);
ALTER TABLE booking ADD CONSTRAINT FK_booking_1 FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE SET NULL;


ALTER TABLE ensemble_lesson ADD CONSTRAINT FK_ensemble_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE;


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE;
ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_1 FOREIGN KEY (instrument_type_id) REFERENCES instrument_type (id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE;
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_1 FOREIGN KEY (instrument_type_id) REFERENCES instrument_type (id);


