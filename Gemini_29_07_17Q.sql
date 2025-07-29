--  ANALYSE DATA FOR MARKETING
-- 

--            1. Joins...
-- Question types:-
          -- Retrive cudtomer name and thier order details from customers and orders tables
SELECT 
    customerss.customerID,
    firstname,
    orderid,
    orderdate,
    totalamount
FROM
    customerss
        JOIN
    orderss ON orderss.customerID = customerss.customerid;
    
    -- . Find all products that have never been orderd
SELECT 
    productss.productID, productname, orderitemss.Quantity
FROM
    productss
        LEFT JOIN
    orderitemss ON orderitemss.productid = productss.productid;
    
    -- List employees and thier department names, including employees not yet assigned to a departments
   SELECT 
    employees.employee_id, first_name, departments.department_id
FROM
    employees
        LEFT JOIN
    departments ON departments.department_id = employees.department_id;
    
    -- Find all common customers between two diffrent sales regions
    SELECT DISTINCT
    customerss.customerid, firstname, status, orderdate
FROM
    customerss
        JOIN
    orderss ON orderss.customerID = customerss.customerid;
    
    -- Identify all orders that include at least one product from a specific category
    SELECT 
    productname, category, orderdate
FROM
    productss
        JOIN
    orderitemss ON orderitemss.productid = productss.productid
        JOIN
    orderss ON orderss.OrderID = orderitemss.OrderID;
    
    
    -- 2.  Subqueries.....
    -- .concept: Queries nested within other queries,
    -- Question Types:
    -- Find all customers who have placed an order for product priced above 100
    SELECT 
    c.customerid, firstname, productname, price
FROM
    customerss c
        JOIN
    orderss o ON o.customerID = c.customerid
        JOIN
    orderitemss oi ON o.OrderID = oi.OrderID
        JOIN
    productss p ON oi.productid = p.productid
WHERE
    price > 100;
    
    
    -- List all employees that have at least one employee with the salary greater than 70000
SELECT 
    emp.employee_id, first_name, salary
FROM
    employees emp
WHERE
    EXISTS( SELECT 
            1
        FROM
            departments dep
        WHERE
            dep.department_id = emp.department_id
                AND salary > 70000);
                
     -- identify products that have never been sold
     SELECT 
    p.productid, productname
FROM
    productss p
WHERE
    NOT EXISTS( SELECT 
            1
        FROM
            orderitemss oi
        WHERE
            oi.productid = p.productid);
            
            
        -- Retrive the names of employees who earn more than the average salary of thier respective departments
        SELECT 
    emp.employee_id, first_name, salary
FROM
    employees emp
WHERE
    salary IN (SELECT 
            AVG(emp.salary) AS avg_sal
        FROM
            departments dep
                JOIN
            employees emp ON emp.department_id = dep.department_id
        GROUP BY department_name);
        
        
     -- 3. Window Functions :-
         -- . concept : Performing calculations acrossa set of tabels
         -- Questions types
         -- Rank products by sales volume within each product category
         select
         p.productid,
         productname,category,
         dense_rank()
         over(partition by category )  as High_volume
         from productss p 
         join
         orderitemss oi 
         on oi.productid = p.productid;
         
         
         -- Calculate the running total of sales for each month in a given year
         select
         distinct
              orderid,
                month(orderdate),
                  sum(totalamount)
                  over(partition by month(orderdate)) as running_total
         from orderss;
         
         
         -- Find the top 3 highest-paid employees in each departments
         select
              distinct 
                employee_id , 
                  first_name, 
                   salary, 
                     dep.department_name,
                 max(salary)over(order by salary desc ) as highest_paid
         from employees emp 
                  join departments dep 
                       on dep.department_id = emp.department_id	
                        limit 3 ;
                        
       -- Calculate the difference in sales between the current month and the previos month
       select 
            orderid,
                month(orderdate),
                    totalamount,
                     totalamount - lag(totalamount)over() as diff
              from orderss;
              
              
              
        -- 4.  Group by and Having Clause
          -- . concept Aggregatingdata
          -- Question Types
          -- . Calculatethe total sales for each product category
        SELECT 
    category, SUM(price * Quantity)
FROM
    productss p
        JOIN
    orderitemss oi ON oi.ProductID = p.ProductID
GROUP BY category;
          
          -- List departments where the average employees salary is above 60000
         SELECT 
    department_id, department_name
FROM
    departments dep
WHERE
    EXISTS( SELECT 
            AVG(salary)
        FROM
            employees emp
        WHERE
            emp.department_id = dep.department_id
                AND salary > 60000);
                
                
-- ✅ SQL Project: Multi-Dimensional Data Analysis for Marketing & HR Insights

-- Alhamdulillah, I successfully completed a hands-on SQL 
-- analysis project focused on real-world business scenarios across sales,
--  products, customer behavior, and employee management.

-- 🔍 Key Highlights:

-- Used JOINS to retrieve complex relationships like customer order details,
--  unassigned employees, and category-specific sales.

-- Applied SUBQUERIES to identify products never ordered, employees earning above
-- department averages, and customers purchasing premium products.

-- Leveraged WINDOW FUNCTIONS (like RANK(), DENSE_RANK(), LAG(), and RUNNING TOTAL) 
-- to perform time-series sales analysis and determine top performers.

-- Performed GROUP BY and HAVING clause operations to calculate aggregated sales per
-- product category and filter high-performing departments.


-- 📊 Skills Demonstrated:

-- Business-driven data retrieval

-- Advanced SQL logic (Window, Subqueries, Aggregations)

-- Data storytelling through structured queries


-- This project has significantly enhanced my confidence in solving analytical
-- SQL challenges and strengthened my readiness for data analyst roles, in shaa Allah.                