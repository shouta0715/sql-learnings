SELECT *,
  AVG(age) OVER (PARTITION BY department_id) AS avg_age,
  COUNT(id) OVER (PARTITION BY department_id) AS count_deparment
FROM employees;

SELECT *,
  COUNT(*) OVER(
    ORDER BY age
  ) AS tmp_count
FROM employees;

SELECT *,
  SUM(order_price) OVER (
    ORDER BY order_date
  ) AS summary
FROM orders
WHERE order_date BETWEEN "2020-01-01" AND "2020-01-31";

SELECT *,
  COUNT(*) OVER (
    PARTITION BY department_id
    ORDER BY age
  ) AS count_value
FROM employees;