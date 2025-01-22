-- Joins

SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

SELECT *
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

SELECT dem.employee_id, age, occupation
FROM employee_demographics AS dem
JOIN employee_salary AS sal #INNER JOIN
	ON dem.employee_id = sal.employee_id
;

SELECT *
FROM employee_demographics AS dem
LEFT OUTER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

SELECT *
FROM employee_demographics AS dem
RIGHT OUTER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

SELECT *
FROM employee_salary AS sal
RIGHT OUTER JOIN employee_demographics AS dem
	ON dem.employee_id = sal.employee_id
;

-- Self Join #a join that you tie the table to itself

SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id
;

SELECT emp1.employee_id emp_santa,
emp1.first_name first_name_santa,
emp1.last_name last_name_santa,
emp2.employee_id emp_name,
emp2.first_name first_name,
emp2.last_name last_name
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id
;

-- Joining multiple tables together

SELECT *
FROM employee_demographics AS dem
JOIN employee_salary AS sal #INNER JOIN
	ON dem.employee_id = sal.employee_id
JOIN parks_departments pd
	ON sal.dept_id = pd.department_id
;
    
SELECT *
FROM parks_departments
;