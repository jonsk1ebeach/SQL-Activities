-- Stored Procedures

SELECT *
FROM employee_salary
WHERE salary >= 50000
;

CREATE PROCEDURE large_salary()
SELECT *
FROM employee_salary
WHERE salary >= 50000;

CALL large_salary;

DELIMITER $$
CREATE PROCEDURE large_salary2()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
	SELECT *
	FROM employee_salary
	WHERE salary >= 10000;
END $$
DELIMITER ;

CALL large_salary2();


DELIMITER $$
CREATE PROCEDURE large_salary3(num INT)
BEGIN
	SELECT *
	FROM employee_salary
    WHERE employee_id = num
    ;
END $$
DELIMITER ;

CALL large_salary3(1);