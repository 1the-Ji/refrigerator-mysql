-- Table: Employee

-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | Id           | int     |
-- | Name         | varchar |
-- | Salary       | int     |
-- | DepartmentId | int     |
-- +--------------+---------+
-- Id is the primary key for this table.
-- Each row contains the ID, name, salary, and department of one employee.
 

-- Table: Department

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | Id          | int     |
-- | Name        | varchar |
-- +-------------+---------+
-- Id is the primary key for this table.
-- Each row contains the ID and the name of one department.
 

-- A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

-- Write an SQL query to find the employees who are high earners in each of the departments.

-- Return the result table in any order.

-- The query result format is in the following example:

 

-- Employee table:
-- +----+-------+--------+--------------+
-- | Id | Name  | Salary | DepartmentId |
-- +----+-------+--------+--------------+
-- | 1  | Joe   | 85000  | 1            |
-- | 2  | Henry | 80000  | 2            |
-- | 3  | Sam   | 60000  | 2            |
-- | 4  | Max   | 90000  | 1            |
-- | 5  | Janet | 69000  | 1            |
-- | 6  | Randy | 85000  | 1            |
-- | 7  | Will  | 70000  | 1            |
-- +----+-------+--------+--------------+

-- Department table:
-- +----+-------+
-- | Id | Name  |
-- +----+-------+
-- | 1  | IT    |
-- | 2  | Sales |
-- +----+-------+

-- Result table:
-- +------------+----------+--------+
-- | Department | Employee | Salary |
-- +------------+----------+--------+
-- | IT         | Max      | 90000  |
-- | IT         | Joe      | 85000  |
-- | IT         | Randy    | 85000  |
-- | IT         | Will     | 70000  |
-- | Sales      | Henry    | 80000  |
-- | Sales      | Sam      | 60000  |
-- +------------+----------+--------+

-- In the IT department:
-- - Max earns the highest unique salary
-- - Both Randy and Joe earn the second-highest unique salary
-- - Will earns the third-highest unique salary

-- In the Sales department:
-- - Henry earns the highest salary
-- - Sam earns the second-highest salary
-- - There is no third-highest salary as there are only two employees

-- Soltion -- 

SELECT
    j.Department AS Department,
    j.Employee AS Employee,
    j.Salary AS Salary
FROM
    (
        SELECT
            d.Name AS Department,
            e.Name AS Employee,
            e.Salary AS Salary,
            DENSE_RANK() OVER (
                PARTITION BY d.Id
                ORDER BY e.Salary DESC
            ) AS `Rank`
        FROM 
            Employee e
        JOIN 
            Department d
        ON
            e.DepartmentId = d.Id
    ) j
WHERE
    j.Rank < 4;
