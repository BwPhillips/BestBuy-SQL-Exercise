SELECT * FROM bestbuy.products;
-- find all products
SELECT * FROM products;

-- find all products that cost $1400
SELECT * FROM products
WHERE Price = 1400;

-- find all products that cost 11.99 or 13.99
SELECT * FROM products
WHERE Price = 11.99 OR Price= 13.99;

-- find all products that do NOT cost 11.99 - using NOT
SELECT * FROM products
WHERE NOT (Price = 11.99 OR Price= 13.99);

-- find  all products and sort them by price from greatest to least
SELECT * FROM products
ORDER BY Price desc;

-- find all employees who don't have a middle initial
SELECT * FROM employees
WHERE MiddleInitial IS NULL;

-- find distinct product prices
SELECT DISTINCT price FROM products;

-- find all employees whose first name starts with the letter ‘j’
SELECT * FROM employees
WHERE FirstName LIKE 'J%';

-- find all Macbooks 
SELECT * FROM products
WHERE name Like 'Macbook%';

-- find all products that are on sale
SELECT * FROM products 
Where OnSale = 1;

-- find the average price of all products --
SELECT AVG(price) AS 'Average Price' FROM products;

-- find all Geek Squad employees who don't have a middle initial --
SELECT * FROM employees
WHERE title ='Geek Squad' AND MiddleInitial IS NULL;

-- find all products from the products table whose stock level is in the range of 500 to 1200.
-- Order by Price from least to greatest. **Try this with the between keyword**
SELECT * FROM products
WHERE StockLevel BETWEEN 500 and 1200;

-- joins: select all the computers from the products table: using 
-- the products table and the categories table, return the product name and the category name  
SELECT Products.Name AS "Product Name", Categories.Name AS "category" FROM products
LEFT JOIN Categories on Products.categoryID = Categories.categoryID
WHERE c.Name = 'computers';

-- joins: find all product names, product prices, and products ratings that have a rating of 5
SELECT p.name AS 'Product Name', p.Price, r.Rating
FROM products AS p
INNER JOIN  reviews AS r
ON p.ProductID = r.ProductID AND r.Rating = 5;

-- joins: find the employee with the most total quantity sold.  use the sum() function and group by
SELECT e.FirstName, e.LastName, SUM(s.Quantity) AS 'Quantity'
FROM sales AS s, employees AS e
WHERE e.EmployeeID = s.EmployeeID
GROUP BY s.EmployeeID
ORDER BY SUM(s.Quantity) DESC LIMIT 2;

-- joins: find the name of the department, and the name of the category for Appliances and Games
/*SELECT d.name AS 'Department Name', c.name'Category Name'
FROM departments as d
INNER JOIN categories as c
ON d.DepartmentID = c.DepartmentID AND c.name ='appliances' OR c.name='games';*/

SELECT d.name AS 'Department Name', c.name'Category Name'
FROM departments as d
LEFT JOIN categories as c
ON d.DepartmentID = c.DepartmentID
WHERE c.name = 'Games' OR c.Name = 'appliances';

-- joins: find the product name, total # sold, and total price sold, for Eagles: Hotel California 
-- You may need to use SUM()
SELECT p.name as 'Product Name', SUM(s.Quantity) AS TotalSold, (p.price * SUM(s.Quantity)) AS Total
FROM products as p 
INNER JOIN sales as s
ON s.productID = p.productID
Where p.productID = 97;

-- joins: find Product name, reviewer name, rating, and comment on the Visio TV. (only return for the lowest rating!)
SELECT p.name AS 'Product Name', r.Reviewer, r.rating, r.comment 
FROM reviews as r
INNER JOIN products as p
ON r.ProductID = p.ProductID
Where r.Rating = 1 AND p.name = 'Visio TV';


-- Extra - May be difficult
-- Your goal is to write a query that serves as an employee sales report.
-- This query should return the employeeID, the employee's first and last name, the name of each product, how many of that product they sold

SELECT e.employeeID, e.FirstName, e.LastName, p.ProductID, p.name AS 'Product Name', (p.price * quantity) AS 'Sales Amount', s.Date
FROM sales as s
INNER JOIN employees as e ON e.employeeID = s.employeeID 
INNER JOIN products as p ON p.ProductID = s.ProductID
ORDER BY e.EmployeeID, e.lastname, e.FirstName, s.Date;