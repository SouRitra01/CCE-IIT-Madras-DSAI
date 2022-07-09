CREATE TABLE EmployeeTable
(  
Employee_id int NOT NULL PRIMARY KEY,  
First_Name varchar(255),  
Last_Name varchar(255),  
Salary int,  
Joining_Date datetime,  
Department varchar(255)  
);  

INSERT INTO EmployeeTable 
VALUES 
(1,'Anika','Arora',100000,'2020-02-14 9:00:00','HR'),
(2,'Veena','Verma',80000,'2011-06-15 9:00:00','Admin'),
(3,'Vishal','Singhal',300000,'2020-02-16 9:00:00','HR'),
(4,'Sushanth','Singh',500000,'2020-02-17 9:00:00','Admin'),
(5,'Bhupal','Bhati',500000,'2011-06-18 9:00:00','Admin'),
(6,'Dheeraj','Diwan',200000,'2011-06-19 9:00:00','Account'),
(7,'Karan','Kumar',75000,'2020-01-14 9:00:00','Account'),
(8,'Chandrika','Chauhan',90000,'2011-04-15 9:00:00','Admin');

select * from EmployeeTable

-- Second Table

CREATE TABLE Employee_BonusTable
(  
Employee_ref_id int NOT NULL,  
Bonus_Amount int,
Bonus_Date datetime,  
FOREIGN KEY (Employee_ref_id) REFERENCES EmployeeTable(Employee_id)  
);  

INSERT INTO Employee_BonusTable 
VALUES 
(1, 5000,'2020-02-15 0:00:00'),
(2, 3000,'2011-06-16 0:00:00'),
(3, 4000,'2020-02-16 0:00:00'),
(1, 4500,'2020-02-16 0:00:00'),
(2, 3500,'2011-06-16 0:00:00');

select * from Employee_BonusTable


-- Third Table

CREATE TABLE Employee_TitleTable
(  
Employee_ref_id int NOT NULL,  
Employee_title varchar(255),
Affective_Date datetime,  
FOREIGN KEY (Employee_ref_id) REFERENCES EmployeeTable(Employee_id)  
);  

INSERT INTO Employee_TitleTable 
VALUES 
(1, 'Manager','2016-02-20 0:00:00'),
(2, 'Executive','2016-06-11 0:00:00'),
(8, 'Executive','2016-06-11 0:00:00'),
(5, 'Manager','2016-06-11 0:00:00'),
(4, 'Asst. Manager','2016-06-11 0:00:00'),
(7, 'Executive','2016-06-11 0:00:00'),
(6, 'Lead','2016-06-11 0:00:00'),
(3, 'Lead','2016-06-11 0:00:00');

select * from Employee_TitleTable

-- QUERIES Q1. Display the “FIRST_NAME” from Employee table using the alias name as Employee_name.

select First_Name as Employee_Name from EmployeeTable

-- Q2.Display “LAST_NAME” from Employee table in upper case.

select upper(Last_Name) from EmployeeTable

--Q3.Display unique values of DEPARTMENT from EMPLOYEE table

select distinct Department from EmployeeTable

--Q4.Display the first three characters of LAST_NAME from EMPLOYEE table.

select SUBSTRING (Last_Name, 1, 3) as LastName_3_Char from EmployeeTable

--Q5. Display the unique values of DEPARTMENT from EMPLOYEE table and prints its length.

select distinct len(Department) as Distict_Dept_length from EmployeeTable

-- Q6. Display the FIRST_NAME and LAST_NAME from EMPLOYEE table into a single column AS FULL_NAME.

select CONCAT(First_name,' ', Last_Name) as Full_name from EmployeeTable


-- Q7. DISPLAY all EMPLOYEE details from the employee table order by FIRST_NAME Ascending

select * from EmployeeTable order by First_Name

-- Q8. Display all EMPLOYEE details order by FIRST_NAME Ascending and DEPARTMENT Descending.

select * from EmployeeTable e order by e.First_Name asc, e.Department desc

--Q9. Display details for EMPLOYEE with the first name as “VEENA” and “KARAN” from EMPLOYEE table.

select * from EmployeeTable where First_Name = 'Veena'
select * from EmployeeTable where First_Name = 'Karan'

-- Q10. Display details of EMPLOYEE with DEPARTMENT name as “Admin”.

select * from EmployeeTable where Department = 'Admin'

-- Q11. DISPLAY details of the EMPLOYEES whose FIRST_NAME contains ‘V’.

select First_Name from EmployeeTable where first_name LIKE '%v%'

-- Q12. DISPLAY details of the EMPLOYEES whose SALARY lies between 100000 and 500000.

select * from EmployeeTable where Salary between 100000 and 500000

-- Q13. Display details of the employees who have joined in Feb-2020.

select * from EmployeeTable where year(Joining_Date) = 2020 and month(Joining_Date) = 2;

-- Q14. Display employee names with salaries >= 50000 and <= 100000.

select * from EmployeeTable where Salary between 50000 and 100000;

-- Q16. DISPLAY details of the EMPLOYEES who are also Managers.

select e.*,
	m.Employee_Title
		from EmployeeTable e
			left outer join Employee_TitleTable m
				on e.employee_id = m.employee_ref_id
					where m.Employee_Title = 'Manager'

-- Q17. DISPLAY duplicate records having matching data in some fields of a table.

SELECT a.*
	FROM EmployeeTable a
JOIN (SELECT First_Name, Last_Name, Salary, Joining_Date, Department, COUNT(*)
	FROM EmployeeTable 
		GROUP BY First_Name, Last_Name, Salary, Joining_Date, Department
			HAVING count(*) > 1 ) b
	ON a.First_Name = b.First_Name
		AND a.Last_Name = b.Last_Name
		AND a.Salary = b.Salary
		AND a.Joining_Date = b.Joining_Date
		AND a.Department = b.Department
			ORDER BY a.Employee_Id

-- Q18. Display only odd rows from a table.

Select * from EmployeeTable where (Employee_id&1)!=0;

-- Q19. Clone a new table from EMPLOYEE table.

SELECT * INTO Employee_dummy FROM EmployeeTable; 
Select * from Employee_dummy


--Q20. DISPLAY the TOP 2 highest salary from a table.

SELECT TOP 2 salary 
     FROM EmployeeTable 
     ORDER BY salary DESC

-- Q21. DISPLAY the list of employees with the same salary.

SELECT e1.*
FROM EmployeeTable e1
INNER JOIN EmployeeTable e2 ON e1.Salary = e2.Salary AND e1.First_Name <> e2.First_Name

--Q22. Display the second highest salary from a table

SELECT MAX(salary) AS salary 
FROM EmployeeTable 
WHERE salary <> (SELECT MAX(salary) 
FROM EmployeeTable);

-- Q23. Display the first 50% records from a table

select top 50 percent * from EmployeeTable;

-- Q24. Display the departments that have less than 4 people in it.

SELECT * FROM EmployeeTable
  WHERE Department IN
  (
    SELECT Department
      FROM EmployeeTable
      GROUP BY Department
      HAVING COUNT(*) < 4
  );

-- Q25. Display all departments along with the number of people in there

SELECT Department, COUNT(*) as Count_Emp
  FROM EmployeeTable
  GROUP BY Department;


-- Q26. Display the name of employees having the highest salary in each department.

SELECT Department, MAX(SALARY) FROM EmployeeTable GROUP BY Department;	

-- Q27. Display the names of employees who earn the highest salary.

SELECT First_Name, Last_Name, Salary, Department
FROM EmployeeTable
WHERE Salary IN
  (SELECT MAX(Salary) FROM EmployeeTable
  );

-- Q 28. Diplay the average salaries for each department

SELECT Department,AVG(Salary) AS 
AVERAGE_SALARY FROM EmployeeTable GROUP BY Department;

-- Q 29. Display the name of the employee who has got maximum bonus

select e.*,
	m.Bonus_Amount
		from EmployeeTable e
			left outer join Employee_BonusTable m
				on e.Employee_id = m.Employee_ref_id
					where m.Bonus_Amount = 
						(Select MAX(Bonus_Amount) from Employee_BonusTable);


-- Q30. Display the first name and title of all the employees

select e.First_Name,
	m.Employee_title
		from EmployeeTable e
			left outer join Employee_TitleTable m
				on e.Employee_id = m.Employee_ref_id
