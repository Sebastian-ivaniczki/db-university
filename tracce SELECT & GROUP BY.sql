-- ---------------------------------------  QUERY CON SELECT

-- 1. Selezionare tutti gli studenti nati nel 1990 (160)

SELECT * FROM `students` WHERE YEAR(`date_of_birth`) = 1990;
-- 2. Selezionare tutti i corsi che valgono più di 10 crediti (479)

SELECT * FROM `courses` WHERE `cfu` > 10;
-- 3. Selezionare tutti gli studenti che hanno più di 30 anni


SELECT * FROM students WHERE YEAR(`date_of_birth`) < YEAR(DATE_SUB(CURRENT_DATE(), INTERVAL 30 YEAR));
-- 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)

SELECT * FROM `courses` WHERE `period` = 'I semestre' AND `year` = '1';
-- 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)

SELECT * FROM `exams` WHERE `date` = DATE('2020-06-20') AND `hour` >= TIME('14:00:00');
-- 6. Selezionare tutti i corsi di laurea magistrale (38)

SELECT * FROM `degrees` WHERE `level` = 'magistrale';
-- 7. Da quanti dipartimenti è composta l'università? (12)

SELECT COUNT(*) FROM `departments`;
-- 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)

SELECT COUNT(*) FROM `teachers` WHERE `phone` IS NULL;

-- ------------------------------------------ QUERY CON GROUP BY


-- 1. Contare quanti iscritti ci sono stati ogni anno
SELECT COUNT(*) AS 'subscribers', YEAR(`enrolment_date`) AS `year` FROM `students` GROUP BY(`year`);

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio

SELECT COUNT(*) AS 'teachers_N' , `office_address` AS 'address' FROM `teachers` GROUP BY(`address`);
-- 3. Calcolare la media dei voti di ogni appello d'esame

SELECT `exam_id` AS 'exam', ROUND(AVG(`vote`)) AS 'avarege vote' FROM `exam_student` GROUP BY(`exam_id`);
-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento

SELECT COUNT(*) AS 'corses', `department_id` AS 'departments' FROM `degrees` GROUP BY(`department_id`);

---------------------   Ex Join  --------------------------

--1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia

SELECT `students`.`name`, `students`.`surname`, `degrees`.`name` AS 'course' FROM `degrees` JOIN `students` ON `degrees`.`id` = `students`.`degree_id` WHERE `degrees`.`name` = 'Corso di Laurea in Economia';

-- 2. Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze

SELECT `degrees`.`name` AS 'course', `departments`.`name`AS 'department' FROM `departments` JOIN `degrees` ON `departments`.`id` = `degrees`.`department_id` WHERE `departments`.`name` = 'Dipartimento di Neuroscienze';

--3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)

SELECT `courses`.`name` AS 'nome corsi', `teachers`.`name`,`teachers`.`surname` FROM `courses` JOIN `course_teacher` ON `courses`.`id` = `course_teacher`.`course_id` JOIN `teachers` ON `teachers`.`id`= `course_teacher`.`teacher_id` WHERE `teachers`.`id`= 44;

--4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome

SELECT `students`.`surname`,`students`.`name`,`degrees`.`name` AS 'course name', `departments`.`name` AS 'department name' FROM `departments` JOIN `degrees` ON `departments`.`id`= `degrees`.`department_id` JOIN `students` ON `degrees`.`id` = `students`.`degree_id` ORDER BY `students`.`name` ASC;

--5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti

SELECT `degrees`.`name` AS 'degree', `courses`.`name` AS 'course', `teachers`.`name` AS 'teacher name', `teachers`.`surname` AS 'teacher surname' FROM `degrees` JOIN `courses` ON `degrees`.`id` = `courses`.`degree_id` JOIN `course_teacher` ON `courses`.`id` = `course_teacher`.`course_id` JOIN `teachers` ON `teachers`.`id` = `course_teacher`.`teacher_id`;

--6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)

SELECT DISTINCT `teachers`.`surname`, `teachers`.`name`, `departments`.`name` AS 'department' FROM `teachers` JOIN `course_teacher` ON `teachers`.`id` = `course_teacher`.`teacher_id` JOIN `courses` ON `courses`.`id` = `course_teacher`.`course_id` JOIN `degrees` ON `degrees`.`id` = `courses`.`degree_id` JOIN `departments` ON `departments`.`id` = `degrees`.`department_id` WHERE `departments`.`name` = 'Dipartimento di Matematica';
