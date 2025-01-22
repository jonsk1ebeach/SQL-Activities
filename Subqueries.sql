-- Subqueries

SELECT*
FROM employee_demographics
WHERE employee_id IN
				(SELECT employee_id #can return 1 column only
					FROM employee_salary
					WHERE dept_id = 1)
;

SELECT first_name, salary,
(SELECT AVG(salary)
FROM employee_salary) as AVG_Salary
FROM employee_salary;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender
;

SELECT AVG(`MAX(age)`) #use back tick if you're pointing to new table name from a subqueries
FROM
(SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender) as AGG_TABLE
;
