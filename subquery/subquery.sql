SELECT MAX(age_count),
  MIN(age_count)
FROM (
    SELECT FLOOR(age / 10) * 10,
      COUNT(*) AS age_count
    FROM employees
    GROUP BY FLOOR(age / 10) * 10
  ) AS age_summary;

SELECT *
FROM customers;

SELECT *
FROM orders;

SELECT first_name,
  last_name,
  id,
  (
    SELECT MAX(order_date)
    FROM orders AS order_max
    WHERE cs.id = order_max.customer_id
  ) AS "最近の注文日"
FROM customers AS csa
WHERE cs.id < 10;

SELECT emp.*,
  CASE
    WHEN emp.department_id = (
      SELECT id
      FROM departments
      WHERE name = "経営企画部"
    ) THEN "経営層"
    ELSE "その他"
  END AS "役割"
FROM employees AS emp;

SELECT emp.*,
  CASE
    WHEN emp.id IN(
      SELECT DISTINCT employee_id
      FROM salaries
      WHERE payment > (
          SELECT AVG(payment)
          FROM salaries
        )
    ) THEN "◯"
    ELSE "☓"
  END AS "給料が平均より高いか"
FROM employees AS emp;