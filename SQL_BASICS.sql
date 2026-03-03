CREATE TABLE student (
    student_id INT,
    name VARCHAR(20) NOT NULL,
    major VARCHAR(20) UNIQUE,
    PRIMARY KEY(student_id)
);

CREATE TABLE student (
    student_id INT AUTO_INCREMENT,
    name VARCHAR(20),
    major VARCHAR(20) DEFAULT 'undecided',
    PRIMARY KEY(student_id)
);

SELECT * FROM student;

-- TABLES

DESCRIBE student;

DROP TABLE student;

ALTER TABLE student ADD gpa DECIMAL(3, 2);

ALTER TABLE studnet DROP COLUMN gpa;

-- INSERTING

INSERT INTO  student VALUES(2, 'Kate', 'Sociology');
INSERT INTO  student(student_id, name) VALUES(2, 'Kate');
INSERT INTO  student(student_id, name) VALUES(3, 'Claire');

-- UPDATING & DELETING

UPDATE student
SET major = 'Bio'

UPDATE student
SET major = 'Comp Sci', name = 'Tom'
WHERE student_id = 4;

UPDATE student
SET major = 'Biochemistry'
WHERE major = 'Bio' OR  major = 'Chemistry';

DELETE FROM student
WHERE student_id = 5;

DELETE FROM student
WHERE name = 'Tom' AND major = 'undecided';

-- BASIC QUERIES
-- <, >, <=, >=, <>, AND, OR
SELECT *(EVERY COLUMN)
FROM student
LIMIT 2;

SELECT name, major
FROM student;

SELECT *
FROM student 
WHERE major IN ('Biology', 'Chemistry') AND student_id > 2;

SELECT *
FROM student
WHERE major = 'Chemistry' AND student_id <= 3;

SELECT student.name, student.major
FROM student
ORDER BY student_id DESC;

SELECT student.name, student.major
FROM student
ORDER BY major, student_id ASC;

-- COMPANY DATABASE INTO

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    birth_day DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT,
    branch_id INT
);

CREATE TABLE branch (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(40),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY(mgr_id) REFERENCES employee(emp_id ON DELETE SET NULL)
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client (
    client_id INT PRIMARY KEY,
    client_name VARCHAR|(40),
    branch_id INT,
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
    emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY(emp_id, client_id),
    FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
    FOREIGN KEY(client_id) REFENCES client(client_id) ON DELETE CASCADE
);

CREATE branch_supplier (
    branch_id INT,
    supplier_name VARCHAR(40),
    supplier_type VARCHAR(40),
    PRIMARY KEY(branch_id, supplier_name),
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

-- Corporate
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000. 102, 2);

-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamform Lables', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daily Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

-- MORE BASIC QUERIES

-- Find all employees
SELECT *
FROM employee;
-- Find all clients
SELECT *
FROM client;
-- Find all employees ordered by salary
SELECT *
FROM employee
ORDER BY salary DESC;
-- Find all employees ordered by sex then name
SELECT *
FROM employee
ORDER BY sex, first_name, last_name;
-- Find the first 5 employees in the table
SELECT * 
FROM employee
LIMIT 5;
-- Find the first and last names of all employees
SELECT first_name, last_name
FROM employee;
-- Find the forename and surnames name of all employees
SELECT first_name AS forename, last_name AS surname
FROM employee;
-- Find out all the different gender
SELECT DISTINCT sex
FROM employee;

-- FUNCTIONS

-- Find the number of employees
SELECT COUNT(emp_id)
FROM employee;
-- Find the number of female employees born after 1970
SELECT COUNT(emp_id)
FROM employee
WHERE sex = 'F' AND brith_date > '1971-01-01';
-- Find the average of all employee's salaries
SELECT AVD(salary)
FROM employee
WHERE sex = 'M';
-- Find the sum of all employee's salaries
SELECT SUM(salary)
FROM employee;
-- Find out how many males and females there are
SELECT COUNT(sex), sex
FROM employee
GROUP BY sex;
-- Find the total sales of each salesman
SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY emp_id;
-- Find the total buys of each client
SELECT SUM(total_sales), client_id
FROM works_with
GROUP BY client_id;

-- WILDCARDS
-- % = any # characters, _ = one character

-- Find any client's who are an LLC
SELECT *
FROM client
WHERE client_name LIKE '%LLC';
-- Find any branch suppliers who are in the label business
SELECT *
FROM branch_supplier
WHERE supplier_name LIKE '% Label%';
-- Find any employee born in October
SELECT *
FROM employee
WHERE birth_date LIKE '____-10%';
-- Find any clients who are schools
SELECT *
FROM client
WHERE client_name LIKE '%school%';

-- UNION

-- Find a list of employee and branch names
SELECT first_name AS Company_Names
FROM employee
UNION
SELECT branch_name
FROM branch;
UNION
SELECT client_name
FROM client;
-- Find a list of all clients & branch suppliers' names
SELECT client_name, branch_id
FROM client
UNION
SELECT supplier_name, branch_id
FROM branch_supplier;
-- Find a list of all money spent or earned by the company
SELECT salary
FROM employee
UNION
SELECT total_sales
FROM works_with;

-- JOINS

INSERT INTO branch VALUES(4, 'BUffalo', NULL, NULL);

-- Find all branches and the names of their managers
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch
-- LEFT JOIN include all rows from left table
-- RIGHT JOIN include all rows from right table
-- FULL JOIN combination of both
ON employee.emp_id = branch.mgr_id;

-- NESTED QUERIES

-- Find names of all employees who have
-- sold over 30000 to a single client
SELECT employee.first_name. employee.last_name
FROM employee
WHERE employee.emp_id IN (
    SELECT works_with.emp_id
    FROM works_with
    WHERE works_with.total_sales > 30000
);

-- Find all clients who are handled by the branch 
-- that Michael Scott manages, Assume you know Michael's ID
SELECT  client.client_name
FROM client
WHERE client.branch_id = (
    SELECT branch.branch_id
    FROM branch
    WHERE branch.mgr_id = 102
    LIMIT 1
);

-- ON DELETE
CREATE TABLE branch (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(40),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

DELETE FROM employee
WHERE emp_id = 102;

SELECT * from branch;
-- In branch and employee, the mgr_id and super_id is NULL for Scramton

CREATE TABLE branch_supplier (
    branch_id INT,
    supplier_name VARCHAR(40),
    supply_type VARCHAR(40),
    PRIMARY KEY(branch_id, supplier_name),
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

DELETE FROM branch
WHERE branch_id = 2;

SELECT * from branch_supplier;
-- The whole row gets deleted instead of being set NULL
-- Primary key can't be NULL so have to CASCADE

-- TRIGGERS

CREATE TABLE trigger_test (
    message VARCHAR(100)
);

DELIMITER $$
CREATE
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES(NEW.first_name);
    END$$
DELIMITER ;

DELIMITER $$
CREATE
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        IF NEW.sex = 'M' THEN
            INSERT INTO trigger_test VALUES('added male employee');
        ELSEIF NEW.sex ='F' THEN
            INSERT INTO trigger_test VALUES('added female employee');
        ELSE
            INSTER INTO trigger_test VALUES('adde other employee')
        END IF;
    END$$
DELIMITER ;

DROP TRIGGER my_trigger;

INSERT INTO employee
VALUES(109, 'Oscar', 'Martinez', '1968-02-19', 'M', 69000, 106, 3);

SELECT * FROM trigger_test;

-- ER (Entity Relationship) DIAGRAMS INTRO

-- ENTITY - An object we want to model & store information about (Student)
-- ATTRIBUTES - Specific pieces of information about an entity (name, grade, gpa)
-- PRIMARY KEY - An attribute that uniquely identify an entry in the database table
-- COMPOSITE ATTRIBUTE - An attribute that can be broken up into sub-attributes
-- MULTI-VALUED ATTRIBUTE - An attribute that can have more than one value (More than one club)
-- DERIVED ATTRIBUTE - An attribute that can be derived from the other attributes(High gpa will have honors)
-- MULTIPLE ENTITIES - You can define more than nen entity in the diagram
-- RELATIONSHIPS - defines a relationship between two entities
-- TOTAL PARTICIPATION - All member must participate in the relationship(Single lines means could, Double lines mean must)
-- RELATIONSHIP ATTRIBUTE - An attribute about the relationship
-- RELATIONSHIP CARDINALITY - The number of instances of an entity from a relation that can be associated with the relation
-- WEAK ENTITY - An entity that cannot be uniquely identified by its attributes alone
-- IDENTIFYING RELATIONSHIP - A relationship that serves to uniquely identify the weak entity

-- DESIGNING AN ER DIAGRAM

-- The foundation of the company is it's employees. Each employee has a name, birthday, sex, salary and a unique number to identify it
-- An employee can work for one branch at a time
-- Each branch will be managed by one of the employees that work there. We'll also want to keep track of when the current manager started as manager.
-- An employee can act as a supervisor for other employees at the branch, an employee may also act as the supervisor for employees at other branches. An employee can have at most one supervisor.
-- A branch may handle a number of clients, however a single client may only be handled by one branch at a time.
-- Employees can work with clients controlled by their branch to sell them stuff. If necessary multiple employees can work with the same client. We'll want to keep track of how many dollars worth of stuff each employee sells to each client they work with.
-- Many branches will need to work with suppliers to buy inventory. For each supplier we'll keep track of their name and the type of product they're selling the branch. A single supplier may supply products to multiple branches.


-- CONVERTING ER DIAGRAMS TO SCHEMAS

-- Step 1: Mapping of Regular Entity Types
-- For each regular entity type create a relation (tale) that includes all the simple attributes of that entity
-- Step 2: Mapping of Weak Entity Types
-- FOr each weak entity type create a relation (table) that includes all simple attributes of the weak entity.
-- The primary key of the new relation should be the partial key of the weak entity plus the primary key of its owner
-- Step 3: Mapping of Binary 1:1 Relationship Types
-- Include one side of the relationship as a foreign key in the other Favor total participation
-- Step 4: Mapping of Binary 1:N Relationship Types
-- Include the 1 side's primary key as a foreign key on the N side relation (table)
-- Step 5: Mapping of Binary M:N Relationship Types
-- Create a new relation (table) who's primary key is a combination of both entities' primary key's. Also include any relationship attributes.
