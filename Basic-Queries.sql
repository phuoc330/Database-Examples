1.SELECT actor.name
	FROM casting, actor
	WHERE casting.movie_id = (SELECT movie.movie_id FROM movie WHERE title = 'The Great
	Gatsby') and actor.actor_id = casting.actor_id;

2.SELECT movie.yr, movie.title, actor.name
	FROM casting, movie, actor
	WHERE casting.ord = 1 AND movie.movie_id = casting.movie_id AND movie.yr = 1994 AND casting.actor_id = actor.actor_id;

3.SELECT movie.title, actor.name, movie.director
	FROM casting, movie, actor
	WHERE movie.movie_id = casting.movie_id AND casting.actor_id = actor.actor_id AND actor.name = movie.director;

4. 
ALTER TABLE grade_type ADD PRIMARY KEY (grade_type_code);
ALTER TABLE course ADD PRIMARY KEY (course_no);
ALTER TABLE zipcode ADD PRIMARY KEY (zip);
ALTER TABLE grade_conversion ADD PRIMARY KEY (letter_grade);
ALTER TABLE instructor ADD PRIMARY KEY (instructor_id);
ALTER TABLE section ADD PRIMARY KEY (section_id);
ALTER TABLE grade_type_weight ADD PRIMARY KEY (grade_type_code, section_id);
ALTER TABLE student ADD PRIMARY KEY (student_id);
ALTER TABLE enrollment ADD PRIMARY KEY (student_id, section_id);
ALTER TABLE grade ADD PRIMARY KEY (grade_type_code, grade_code_occurrence, student_id, section_id);

ALTER TABLE instructor ADD CONSTRAINT zip_instructor_fk FOREIGN KEY (zip) REFERENCES zipcode(zip);
ALTER TABLE student ADD CONSTRAINT zip_student_fk FOREIGN KEY (zip) REFERENCES zipcode(zip);
ALTER TABLE section ADD CONSTRAINT section_course_no_fk FOREIGN KEY (course_no) REFERENCES course(course_no);
ALTER TABLE section ADD CONSTRAINT section_instructor_id_fk FOREIGN KEY (Instructor_id) REFERENCES instructor(Instructor_id);
ALTER TABLE grade_type_weight ADD CONSTRAINT grade_weight_section_id_fk FOREIGN KEY (section_id) REFERENCES section(section_id);
ALTER TABLE grade_type_weight ADD CONSTRAINT grade_code_fk FOREIGN KEY (grade_type_code) REFERENCES grade_type(grade_type_code);
ALTER TABLE enrollment ADD CONSTRAINT enroll_student_fk FOREIGN KEY (student_id) REFERENCES student(student_id);
ALTER TABLE enrollment ADD CONSTRAINT enroll_section_fk FOREIGN KEY (section_id) REFERENCES section(section_id);
ALTER TABLE grade ADD CONSTRAINT grade_student_fk FOREIGN KEY (student_id) REFERENCES student(student_id);
ALTER TABLE grade ADD CONSTRAINT grade_section_fk FOREIGN KEY (section_id) REFERENCES section(section_id);

5.SELECT student.first_name, enrollment.section_id, instructor.first_name, instructor.last_name
	FROM enrollment, student, instructor, section
	WHERE instructor.last_name = 'Morris' AND enrollment.student_id = student.student_id AND instructor.instructor_id = section.instructor_id AND enrollment.section_id = section.section_id;

6.SELECT DISTINCT student.first_name
	FROM zipcode
	INNER JOIN student ON student.zip = zipcode.zip
	INNER JOIN instructor ON instructor.zip = zipcode.zip;

7.SELECT COUNT (DISTINCT student.student_id) - COUNT (DISTINCT enrollment.student_id) as not_enrolled
	FROM student, enrollment;

8.SELECT student.first_name
	FROM course, section, enrollment, student
	WHERE course.cost > 1700 AND course.course_no = section.course_no AND section.section_id = enrollment.section_id AND enrollment.student_id = student.student_id;

9.SELECT instructor.first_name, COUNT (student_id) AS number_of_students
	FROM section
	INNER JOIN enrollment ON enrollment.section_id = section.section_id
	INNER JOIN instructor ON instructor.instructor_id = section.instructor_id
	GROUP BY instructor.first_name;
