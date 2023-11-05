UPDATE employees AS emp
SET emp.age = emp.age + 2
WHERE emp.department_id = (
    SELECT id
    FROM departments
    WHERE name = "営業部"
  );

UPDATE employees AS emp
  LEFT JOIN departments AS dt ON emp.department_id = dt.id
SET emp.department_name = COALESCE(dt.name, "不明");

WITH tmp_sales AS (
  SELECT it.store_id,
    SUM(od.order_amount * od.order_price) AS summary
  FROM items AS it
    INNER JOIN orders AS od ON it.id = od.item_id
  GROUP BY it.store_id
)
UPDATE stores AS st
  INNER JOIN tmp_sales AS ts ON ts.store_id = st.id
SET st.all_sales = ts.summary;

DELETE FROM employees
WHERE department_id IN(
    SELECT id
    FROM departments
    WHERE name = "開発部"
  );

CREATE TABLE customer_orders(
  name VARCHAR(255),
  order_date DATE,
  sales INT,
  total_sales INT
);

INSERT INTO customer_orders
SELECT CONCAT(ct.first_name, ct.last_name),
  od.order_date,
  od.order_amount * od.order_price,
  SUM(od.order_amount * od.order_price) OVER (
    PARTITION BY CONCAT(ct.first_name, ct.last_name)
    ORDER BY od.order_date
  ) AS "合計"
FROM customers AS ct
  INNER JOIN orders AS od ON ct.id = od.customer_id;