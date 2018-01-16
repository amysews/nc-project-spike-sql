-- To run this script in terminal:
-- psql -f main.sql

DROP DATABASE IF EXISTS data_spike;
CREATE DATABASE data_spike;

\c data_spike;

CREATE TABLE people (
id SERIAL PRIMARY KEY,
first_name VARCHAR (30) NOT NULL,
surname VARCHAR (30) NOT NULL,
submitter BOOLEAN NOT NULL,
questioner BOOLEAN NOT NULL,
region      VARCHAR(30), 
email        VARCHAR(50) NOT NULL,
user_password    VARCHAR (20) NOT NULL,
gender      VARCHAR (10) NOT NULL,
dob           DATE,
occupation     VARCHAR (20) NOT NULL,
joined_date TIMESTAMP DEFAULT NOW()
);

CREATE TABLE questions (
id SERIAL PRIMARY KEY,
asker_id INT NOT NULL,
question_audio VARCHAR (300),
question_text VARCHAR (300) NOT NULL,
question_topic VARCHAR (40),
question_keywords VARCHAR (100),
question_answered BOOLEAN NOT NULL,
question_time_stamp TIMESTAMP DEFAULT NOW(),
FOREIGN KEY (asker_id) REFERENCES people(id)
);

CREATE TABLE answers (
id SERIAL PRIMARY KEY,
answerer_id INT NOT NULL,
question_id INT NOT NULL,
answer_text VARCHAR (100) NOT NULL,
answer_audio VARCHAR (50),
answer_time_stamp TIMESTAMP DEFAULT NOW(),
FOREIGN KEY (answerer_id) REFERENCES people(id),
FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO people (first_name, surname, submitter, questioner, region, email, user_password, gender, dob, occupation)
VALUES ('Bob', 'Smith', true, false, 'Manchester', 'bob@gmail.com', 'password123', 'Male', '1990-01-01', 'Student'),
 ('John',	'Doe', true, false, 'Manchester',	'john@gmail.com',	'password123', 'Male', '1980-02-02', 'Teacher'), 
 ('Jane',	'Jones', false, true,	'Liverpool', 'jane@gmail.com', 'password123', 'Female', '1930-03-03', 'Nurse'), 
('Dorothy',	'Adams', false, true,	'Leeds', 'dorothy@gmail.com', 'password123',	'Female', '1920-04-04', 'Accountant');

INSERT INTO questions (asker_id, question_audio, question_text, question_topic, question_keywords, question_answered)
VALUES (1, null, 'Where did you meet your partner?', 'Relationships', 'Relationships', true),
(2, null, 'What did you study at school?', 'Education', 'Education', true);

INSERT INTO answers (answerer_id, question_id, answer_text)
VALUES (3, 1, 'Met them at a dance'),
 (4, 1, 'Our parents introduced each other'),
  (3, 2, 'We studied maths, chemistry, carpentry & sewing'),
   (4, 2, 'Half of our teachers left as it was the war, so we did nothing for 5 years');

SELECT * FROM people;

SELECT question_text, first_name, surname FROM questions JOIN people ON questions.asker_id = people.id;

SELECT * FROM answers;