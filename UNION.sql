-- Unions allows you to combine rows together

SELECT age, gender
FROM employee_demographics
UNION
SELECT first_name, last_name
FROM employee_salary
;
SELECT first_name, last_name
FROM employee_demographics
UNION DISTINCT # unique data only, UNION ALL includes all the data even the duplicates
SELECT first_name, last_name
FROM employee_salary
;

SELECT first_name, last_name, 'OLD Man' Label
FROM employee_demographics
WHERE age > 40 AND gender = 'MALE'
UNION
SELECT first_name, last_name, 'OLD Lady' Label
FROM employee_demographics
WHERE age > 40 AND gender = 'FEMALE'
UNION
SELECT first_name, last_name, 'Highly Paid Employee' Label
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name
;