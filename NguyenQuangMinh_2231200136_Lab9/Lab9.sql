-- II
-- 1.....
ALTER TABLE EMPLOYEES
ADD CONSTRAINT chk_gender_employees
CHECK (gender IN ('Nam', 'Nu'));
-- 2.....
ALTER TABLE EMPLOYEES
ADD CONSTRAINT chk_salary_positive
CHECK (salary > 0);
-- 3.....
ALTER TABLE RELATIVE
ADD CONSTRAINT chk_relationship
CHECK (relationship IN ('Vo chong', 'Con trai', 'Con gai', 'Me ruot', 'Cha ruot'));
-- III
-- 1.....
SELECT * FROM EMPLOYEES WHERE (salary > 25000 AND departmentID = 4) OR (salary > 30000 AND departmentID = 5);
-- 2.....
SELECT CONCAT(lastName, ' ', middleName, ' ', firstName) AS fullName FROM EMPLOYEES WHERE address LIKE '%TPHCM%';
-- 3.....
SELECT dateOfBirth FROM EMPLOYEES WHERE lastName = 'Dinh' AND middleName = 'Ba' AND firstName = 'Tien';
-- 4.....
SELECT CONCAT(e.lastName, ' ', e.middleName, ' ', e.firstName) AS fullName
FROM EMPLOYEES e
JOIN ASSIGNMENT a ON e.employeeID = a.employeeID
JOIN PROJECTS p ON a.projectID = p.projectID
WHERE p.projectName = 'San pham X'
  AND e.departmentID = 5
  AND CONCAT(e.lastName, ' ', e.middleName, ' ', e.firstName) = 'Nguyen Thanh Tung';
-- 5.....
SELECT d.departmentName, CONCAT(e.lastName, ' ', e.middleName, ' ', e.firstName) AS managerName FROM DEPARTMENT d JOIN EMPLOYEES e ON d.managerID = e.employeeID;
-- 6.....
SELECT p.projectID, p.projectName, p.projectAddress, 
       p.departmentID, d.departmentName, 
       d.departmentID, d.dateOfEmployment
FROM PROJECTS p
JOIN DEPARTMENT d ON p.departmentID = d.departmentID;
-- 7.....
SELECT CONCAT(e.lastName, ' ', e.middleName, ' ', e.firstName) AS employeeName, 
       r.relativeName
FROM EMPLOYEES e
JOIN RELATIVE r ON e.employeeID = r.employeeID
WHERE e.gender = 'Nu';
-- 8.....
SELECT p.projectID, p.departmentID, 
       CONCAT(m.lastName, ' ', m.middleName, ' ', m.firstName) AS managerName, 
       e.address, e.dateOfBirth
FROM PROJECTS p
JOIN DEPARTMENT d ON p.departmentID = d.departmentID
JOIN EMPLOYEES m ON d.managerID = m.employeeID
JOIN EMPLOYEES e ON e.departmentID = p.departmentID
WHERE p.projectAddress LIKE '%Hanoi%';
-- 9.....
SELECT e.employeeID, 
       CONCAT(e.lastName, ' ', e.middleName, ' ', e.firstName) AS employeeName, 
       CONCAT(m.lastName, ' ', m.middleName, ' ', m.firstName) AS managerName
FROM EMPLOYEES e
LEFT JOIN EMPLOYEES m ON e.managerID = m.employeeID;
-- 10.....
SELECT e.employeeID, 
       CONCAT(e.lastName, ' ', e.middleName, ' ', e.firstName) AS employeeName,
       CONCAT(m.lastName, ' ', m.middleName, ' ', m.firstName) AS departmentHeadName
FROM EMPLOYEES e
JOIN DEPARTMENT d ON e.departmentID = d.departmentID
JOIN EMPLOYEES m ON d.managerID = m.employeeID;
-- 11.....
SELECT CONCAT(e.lastName, ' ', e.middleName, ' ', e.firstName) AS employeeName, 
       p.projectName
FROM EMPLOYEES e
JOIN ASSIGNMENT a ON e.employeeID = a.employeeID
JOIN PROJECTS p ON a.projectID = p.projectID;
-- 12.....
SELECT p.projectName, SUM(a.workingHour) AS totalHoursWorked
FROM PROJECTS p
JOIN ASSIGNMENT a ON p.projectID = a.projectID
GROUP BY p.projectName;
-- 13.....
SELECT d.departmentName, 
-- 13.....
SELECT d.departmentName, AVG(e.salary) AS averageSalary
FROM DEPARTMENT d
JOIN EMPLOYEES e ON d.departmentID = e.departmentID
GROUP BY d.departmentName;
-- 14.....
SELECT d.departmentName, COUNT(e.employeeID) AS numberOfEmployees
FROM DEPARTMENT d
JOIN EMPLOYEES e ON d.departmentID = e.departmentID
GROUP BY d.departmentName
HAVING AVG(e.salary) > 30000;
-- 15.....
SELECT DISTINCT p.projectID
FROM PROJECTS p
LEFT JOIN ASSIGNMENT a ON p.projectID = a.projectID
LEFT JOIN EMPLOYEES e ON a.employeeID = e.employeeID
LEFT JOIN DEPARTMENT d ON p.departmentID = d.departmentID
LEFT JOIN EMPLOYEES m ON d.managerID = m.employeeID
WHERE e.lastName = 'Dinh'
   OR m.lastName = 'Dinh';
-- 16.....
SELECT e.lastName, e.middleName, e.firstName
FROM EMPLOYEES e
JOIN RELATIVE r ON e.employeeID = r.employeeID
GROUP BY e.employeeID, e.lastName, e.middleName, e.firstName
HAVING COUNT(r.relativeName) > 2;
-- 17.....
SELECT e.lastName, e.middleName, e.firstName
FROM EMPLOYEES e
LEFT JOIN RELATIVE r ON e.employeeID = r.employeeID
WHERE r.employeeID IS NULL;
-- 18.....
SELECT DISTINCT m.lastName, m.middleName, m.firstName
FROM EMPLOYEES m
JOIN DEPARTMENT d ON m.employeeID = d.managerID
JOIN RELATIVE r ON m.employeeID = r.employeeID;
-- 19.....
SELECT DISTINCT m.lastName
FROM EMPLOYEES m
JOIN DEPARTMENT d ON m.employeeID = d.managerID
JOIN RELATIVE r ON m.employeeID = r.employeeID
WHERE r.relationship not like 'Vo chong';
-- 20.....
SELECT CONCAT(e.lastName, ' ', e.middleName, ' ', e.firstName) AS fullName
FROM EMPLOYEES e
JOIN DEPARTMENT d ON e.departmentID = d.departmentID
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM EMPLOYEES e2
    JOIN DEPARTMENT d2 ON e2.departmentID = d2.departmentID
    WHERE d2.departmentName = 'Nghien cuu'
);
-- 21.....
SELECT d.departmentName, CONCAT(m.lastName, ' ', m.middleName, ' ', m.firstName) AS managerName
FROM DEPARTMENT d
JOIN EMPLOYEES m ON d.managerID = m.employeeID
JOIN (
    SELECT departmentID, COUNT(employeeID) AS numEmployees
    FROM EMPLOYEES
    GROUP BY departmentID
    ORDER BY numEmployees DESC
    LIMIT 1
) dept_max ON d.departmentID = dept_max.departmentID;
-- 22.....
SELECT DISTINCT e.lastName, e.middleName, e.firstName, e.address
FROM EMPLOYEES e
JOIN ASSIGNMENT a ON e.employeeID = a.employeeID
JOIN PROJECTS p ON a.projectID = p.projectID
JOIN DEPARTMENT d ON e.departmentID = d.departmentID
JOIN DEPARTMENTADDRESS da ON d.departmentID = da.departmentID
WHERE p.projectAddress LIKE '%TPHCM%'
  AND da.address NOT LIKE '%TPHCM%';
-- 23.....
SELECT DISTINCT e.lastName, e.middleName, e.firstName, e.address
FROM EMPLOYEES e
JOIN ASSIGNMENT a ON e.employeeID = a.employeeID
JOIN PROJECTS p ON a.projectID = p.projectID
JOIN DEPARTMENT d ON e.departmentID = d.departmentID
JOIN DEPARTMENTADDRESS da ON d.departmentID = da.departmentID
WHERE p.projectAddress LIKE '%' || (SELECT DISTINCT SUBSTRING(p.projectAddress, LOCATE(',', p.projectAddress) + 1) FROM PROJECTS p WHERE p.projectID = a.projectID) || '%'
  AND da.address NOT LIKE '%' || (SELECT DISTINCT SUBSTRING(p.projectAddress, LOCATE(',', p.projectAddress) + 1) FROM PROJECTS p WHERE p.projectID = a.projectID) || '%';
-- 24.....
DELIMITER //
CREATE PROCEDURE ListEmployeeInfoByDepartment(IN deptName VARCHAR(255))
BEGIN
    SELECT e.lastName, e.middleName, e.firstName, e.address
    FROM EMPLOYEES e
    JOIN DEPARTMENT d ON e.departmentID = d.departmentID
    WHERE d.departmentName = deptName;
END //
DELIMITER ;
-- 25.....
DELIMITER //
CREATE PROCEDURE SearchProjectsByEmployeeLastName(IN empLastName VARCHAR(255))
BEGIN
    SELECT p.projectID, p.projectName, p.projectAddress
    FROM PROJECTS p
    JOIN ASSIGNMENT a ON p.projectID = a.projectID
    JOIN EMPLOYEES e ON a.employeeID = e.employeeID
    WHERE e.lastName = empLastName;
END //
DELIMITER ;
-- 26.....
DELIMITER //
CREATE FUNCTION GetAverageSalary(deptID INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE avgSalary DECIMAL(10, 2);
    
    SELECT AVG(salary) INTO avgSalary
    FROM EMPLOYEES
    WHERE departmentID = deptID;
    
    RETURN avgSalary;
END //
DELIMITER ;
-- 27.....
DELIMITER //
CREATE FUNCTION IsEmployeeInProject(empID INT, projID INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE isInvolved BOOLEAN;
    
    SELECT CASE
               WHEN COUNT(*) > 0 THEN TRUE
               ELSE FALSE
           END INTO isInvolved
    FROM ASSIGNMENT
    WHERE employeeID = empID AND projectID = projID;
    
    RETURN isInvolved;
END //
DELIMITER ;