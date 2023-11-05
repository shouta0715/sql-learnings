SELECT emp.id,
  emp.first_name,
  dt.id AS depertment_id,
  dt.`name` AS depertment_name
FROM employees AS emp
  INNER JOIN departments AS dt ON emp.department_id = dt.id;

SELECT emp.id,
  emp.first_name,
  emp.last_name,
  emp.department_id,
  dt.id,
  dt.name
FROM employees AS emp
  LEFT JOIN departments AS dt ON emp.department_id = dt.id;

-- customer,orders,items,storesを紐付ける(INNER JOIN)
-- customers.idで並び替える(ORDERY BY)
SELECT ct.id,
  ct.last_name,
  od.item_id,
  od.order_amount,
  od.order_price,
  od.order_date,
  it.`name`,
  st.`name`
FROM customers AS ct
  INNER JOIN orders AS od ON ct.id = od.customer_id
  INNER JOIN items AS it ON od.item_id = it.id
  INNER JOIN stores AS st ON st.id = it.store_id
ORDER BY ct.id;

-- customer,orders,items,storesを紐付ける(INNER JOIN)
-- customers.idで並び替える(ORDERY BY)
-- customers_idが10でorders.order_dateが2020-08-01よりあと (WHERE)
SELECT ct.id,
  ct.last_name,
  od.item_id,
  od.order_amount,
  od.order_price,
  od.order_date,
  it.`name`,
  st.`name`
FROM customers AS ct
  INNER JOIN orders AS od ON ct.id = od.customer_id
  INNER JOIN items AS it ON od.item_id = it.id
  INNER JOIN stores AS st ON st.id = it.store_id
WHERE ct.id = 10
  AND od.order_date > "2020-08-01"
ORDER BY ct.id;

-- GROUP BYの紐づけ
SELECT *
FROM customers AS ct
  INNER JOIN (
    SELECT customer_id,
      SUM(order_amount * order_price) AS summary_price
    FROM orders
    GROUP BY customer_id
  ) AS order_summary ON ct.id = order_summary.customer_id;

SELECT *
FROM employees AS e1
  CROSS JOIN employees AS e2 ON e1.id < e2.id;

-- 計算結果とCASEで紐づけ
SELECT *,
  CASE
    WHEN cs.age > summary_customers.avg_age THEN "◯"
    ELSE "✗"
  END AS "平均年齢よりも年齢が高いか"
FROM customers AS cs
  CROSS JOIN (
    SELECT AVG(age) AS avg_age
    FROM customers
  ) AS summary_customers -- departmentsから営業部の人を取り出して,employeesと結合する。
SELECT *
FROM employees AS e
  INNER JOIN departments AS d ON e.department_id = d.id
WHERE d.name = "営業部";

WITH tmp_departments AS (
  SELECT id
  FROM departments
  WHERE name = "営業部"
)
SELECT *
FROM employees AS e
  INNER JOIN tmp_departments ON e.department_id = tmp_departments.id;

-- storesテーブルからid 1,2,3のものを取り出す。(WHERE)
-- itemsテーブルとひもずけ、itemsテーブルとordersテーブルを紐付ける(INNER JOIN)
-- ordersテーブルのorder_amount * order_priceの合計値をstoresテーブルのstore_name毎に集計する。(GROUP BY)
WITH tmp_stores AS (
  SELECT *
  FROM stores
  WHERE id IN(1, 2, 3)
),
tmp_items_orders AS (
  SELECT items.id AS item_id,
    tmp_stores.id AS store_id,
    orders.id AS order_id,
    orders.order_amount AS order_amount,
    orders.order_price AS order_price,
    tmp_stores.name AS store_name
  FROM tmp_stores
    INNER JOIN items ON tmp_stores.id = items.store_id
    INNER JOIN orders ON items.id = orders.item_id
)
SELECT store_name,
  SUM(order_amount * order_price)
FROM tmp_items_orders
GROUP BY store_name