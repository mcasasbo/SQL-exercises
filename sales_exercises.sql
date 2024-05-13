/* From Direction Department ask us to pass them the following information*/


-- 1 Total products sold 

SELECT COUNT(id_product) AS Tsold
	FROM sales

  
-- 2. How many unique SKUs have been sold?

SELECT COUNT(DISTINCT id_product) AS References_sold
FROM sales;

-- 3. Average product sold per SKU/product 

SELECT id_product, ROUND(AVG(product_count), 1) AS avg_products_sold
FROM (
	SELECT id_product, COUNT(*) AS product_count
    FROM sales
    GROUP BY id_product
) AS product_avg_sales
GROUP BY id_product;

-- 4. List of products with prices over 700€

SELECT description
FROM products
	WHERE net_margin > 700
;

-- 5. List of employees under 40 years old

SELECT name, first_name, birthday,
       ROUND(DATEDIFF(CURRENT_DATE(), birthday) / 365 , 1) AS age
FROM staff
ORDER BY age ASC;

-- 6. List of employees by region 

SELECT s.name, s.first_name, o.description
FROM staff AS s
	INNER JOIN office AS o 
		ON s.id_office = o.id_office
ORDER BY o.description
;

-- 7. List of office without employees assigned

SELECT o.id_office, o.description
FROM office AS o
	LEFT JOIN staff AS s
		ON o.id_office = s.id_office
WHERE s.id_employee IS NULL
GROUP BY o.id_office
;
-- 8. List of employees total sales

SELECT s.name, s.first_name AS employee_name, o.description, COUNT(sa.id_sale) AS total_sales
FROM  staff as s
	LEFT JOIN sales AS sa ON s.id_employee = sa.id_employee
	LEFT JOIN office as o ON s.id_office = o.id_office
GROUP BY s.first_name ASC, s.name, o.description
ORDER BY total_sales DESC;

-- 9. Sales net_margin between January 15 and February 15

SELECT SUM(p.net_margin * s.Q_prod_sold) AS T_net_margin
FROM (
    SELECT id_product, COUNT(id_product) AS Q_prod_sold
    FROM sales
    WHERE date BETWEEN '2020-01-15' AND '2020-02-15'
    GROUP BY id_product
) AS s
	JOIN products AS p ON s.id_product = p.id_product
;

-- 10. List of products sold (description, price, quantity, Total net margin 

SELECT p.description AS Product, p.net_margin AS Price, s.Total_sold, p.net_margin * s.Total_sold AS Total_Netmargin
FROM (
    SELECT id_product, COUNT(id_product) AS Total_sold
    FROM sales
    GROUP BY id_product
) AS s
JOIN products AS p ON s.id_product = p.id_product
ORDER BY Total_Netmargin DESC;

-- 11. Ranking of best sellers (criterion: by number of products sold)

SELECT st.id_employee, CONCAT(st.name, ' ',  st.first_name) AS Full_name, s.Total_sold
FROM(SELECT id_employee, COUNT(id_product) AS Total_sold
	FROM sales
	GROUP BY id_employee
) AS s
JOIN staff AS st ON s.id_employee = st.id_employee
ORDER BY s.Total_sold DESC
;

-- 12. Ranking of best customers (criterion: by income that the company obtains)

SELECT c.id_customer, CONCAT(c.name, ' ', c.first_name) AS Name, ps.Total_proffit
FROM(
	SELECT s.id_customer, s.Total_purchased * p.net_margin AS Total_proffit 
	FROM(
		SELECT id_customer, id_product, COUNT(id_product) AS Total_purchased
		FROM sales
		GROUP BY id_customer
	) AS s
	JOIN products AS p ON s.id_product = p.id_product) AS ps
JOIN customers as c ON ps.id_customer = c.id_customer
ORDER BY Total_proffit DESC
;

-- 13. Ranking of best Barcelona office customers (criterion: by income that the company obtains) 

SELECT scp.ID, scp.Name, scp.Total_proffit
FROM (
    SELECT cp.ID, cp.Name, cp.Total_proffit, st.id_office
    FROM (
        SELECT c.id_customer AS ID, CONCAT(c.name, ' ', c.first_name) AS Name, ps.Total_proffit, ps.id_employee
        FROM (
            SELECT s.id_employee, s.id_customer, s.Total_purchased * p.net_margin AS Total_proffit 
            FROM (
                SELECT id_employee, id_customer, id_product, COUNT(id_product) AS Total_purchased
                FROM sales
                GROUP BY id_customer
            ) AS s
            JOIN products AS p ON s.id_product = p.id_product
        ) AS ps
        JOIN customers AS c ON ps.id_customer = c.id_customer
        ORDER BY Total_proffit DESC
    ) AS cp
    JOIN staff AS st ON cp.id_employee = st.id_employee
) AS scp
JOIN office AS o ON scp.id_office = o.id_office
WHERE o.description = 'BARCELONA'
;

-- 14. Count of products that have more than 10 products sold
SELECT s.id_product AS ID, p.description, s.Total_sold
FROM(
	SELECT id_product, COUNT(id_product) AS Total_sold
	FROM sales
	GROUP BY id_product
	HAVING Total_sold >= 10
    ) AS s
JOIN products as p ON s.id_product = p.id_product
;