
1 - SELECT DISTINCT student.student_name FROM student WHERE student.level="SR" AND student.student_id IN ( SELECT enrolled.student_id FROM enrolled NATURAL JOIN semester_course WHERE enrolled.course_code = semester_course.course_code AND semester_course.prof_id='1');

2 - SELECT DISTINCT student.student_name ,MAX(student.age) FROM student WHERE student.major="History" OR student.student_id IN ( SELECT enrolled.student_id FROM enrolled NATURAL JOIN semester_course  NATURAL JOIN professor WHERE professor.prof_name="Michael Miller");

3 - SELECT DISTINCT student.student_name , course.name , student.student_id FROM student LEFT OUTER JOIN enrolled ON student.student_id = enrolled.student_id LEFT OUTER JOIN course ON course.course_code = enrolled.course_code  ; 

4 - SELECT professor.prof_name , COUNT(enrolled.course_code)  FROM professor NATURAL JOIN semester_course LEFT OUTER JOIN enrolled ON semester_course.course_code = enrolled.course_code  AND semester_course.quarter = enrolled.quarter AND enrolled.year =semester_course.year
GROUP BY professor.prof_id  HAVING COUNT(enrolled.student_id)<5
                                                                                                
5 - SELECT DISTINCT student.student_name FROM student WHERE student.student_id IN ( SELECT enrolled.student_id FROM enrolled NATURAL JOIN semester_course WHERE enrolled.course_code = semester_course.course_code AND semester_course.prof_id='2');

6  - SELECT course.name ,  course.course_code FROM course WHERE course.course_code NOT IN ( SELECT enrolled.course_code  FROM enrolled ) UNION ( SELECT C2.name  ,C2.course_code FROM course AS C2 JOIN semester_course ON semester_course.course_code=C2.course_code JOIN  professor  ON professor.prof_id = semester_course.prof_id  JOIN department ON department.dept_id = professor.dept_id  WHERE department.dept_name="Computer Science");

7 - SELECT DISTINCT student.student_name FROM student WHERE student.student_name like 'M%' AND student.age < '20'
UNION SELECT DISTINCT professor.prof_name FROM professor NATURAL JOIN semester_course Where professor.prof_name like 'M%' 
GROUP BY professor.prof_id
HAVING COUNT(semester_course.course_code)>2; 

8 - SELECT professor.prof_name , professor.dept_id , COUNT(semester_course.course_code)  FROM professor NATURAL JOIN semester_course WHERE professor.dept_id  = 1 OR professor.dept_id  = 2 OR professor.dept_id  = 3 OR professor.dept_id  = 4  GROUP BY professor.prof_id HAVING COUNT(semester_course.course_code)<2 

9 - SELECT student.student_name , professor.prof_name  FROM enrolled NATURAL JOIN semester_course RIGHT OUTER JOIN student ON student.student_id  = enrolled.student_id   RIGHT OUTER JOIN professor  ON semester_course.prof_id = professor.prof_id UNION  SELECT student.student_name , professor.prof_name FROM enrolled  NATURAL JOIN semester_course RIGHT OUTER JOIN student ON student.student_id  = enrolled.student_id   LEFT OUTER JOIN professor  ON semester_course.prof_id = professor.prof_id ;

10 - SELECT C.name , C.course_code, P.prof_name , P.prof_id 
FROM   professor AS P NATURAL JOIN semester_course AS SC NATURAL JOIN course AS C
GROUP BY P.prof_id,SC.course_code
HAVING COUNT(SC.course_code)>1 ;

11 - SELECT D.dept_name FROM   department AS D WHERE D.dept_id IN 
( SELECT D1.dept_id FROM (professor RIGHT OUTER JOIN department AS D1 ON professor.dept_id = D1.dept_id  ) LEFT OUTER JOIN semester_course AS SC ON professor.prof_id=SC.prof_id
GROUP BY    D1.dept_id
HAVING  count(SC.course_code)<3) ;