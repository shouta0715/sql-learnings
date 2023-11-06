/* 1. employeesテーブルとcustomersテーブルの両方から、それぞれidが10より小さいレコードを取り出します。
 
 両テーブルのfirst_name, last_name, ageカラムを取り出し、行方向に連結します。
 
 連結の際は、重複を削除するようにしてください。*/
SELECT first_name,
  last_name,
  age
FROM employees
WHERE id < 10
UNION
SELECT first_name,
  last_name,
  age
FROM customers
WHERE id < 10;

/* 2. departmentsテーブルのnameカラムが営業部の人の、月収の最大値、最小値、平均値、合計値を計算してください。
 
 employeesテーブルのdepartment_idとdepartmentsテーブルのidが紐づけられ
 
 salariesテーブルのemployee_idとemployeesテーブルのidが紐づけられます。
 
 月収はsalariesテーブルのpaymentカラムに格納されています */
DESCRIBE departments;

SELECT SUM(s.payment) AS "合計値",
  MAX(s.payment) AS "最大値",
  MIN(s.payment) AS "最小値",
  AVG(s.payment) AS "平均値"
FROM departments AS d
  INNER JOIN employees AS e ON e.department_id = d.id
  INNER JOIN salaries AS s ON e.id = s.employee_id
WHERE d.`name` = "営業部";

/* 3. classesテーブルのidが、5よりも小さいレコードとそれ以外のレコードを履修している生徒の数を計算してください。
 
 classesテーブルのidとenrollmentsテーブルのclass_id、enrollmentsテーブルのstudent_idとstudents.idが紐づく
 
 classesにはクラス名が格納されていて、studentsと多対多で結合される */
DESCRIBE classes;

DESCRIBE enrollments;

DESCRIBE students;

SELECT CASE
    WHEN c.id < 5 THEN "クラス1"
    ELSE "クラス2"
  END AS "クラス分類",
  COUNT(*)
FROM classes AS c
  INNER JOIN enrollments AS e ON e.class_id = c.id
  INNER JOIN students AS s ON s.id = e.student_id
GROUP BY CASE
    WHEN c.id < 5 THEN "クラス1"
    ELSE "クラス2"
  END;

/* 4. ageが40より小さい全従業員で月収の平均値が7,000,000よりも大きい人の、月収の合計値と平均値を計算してください。
 
 employeesテーブルのidとsalariesテーブルのemployee_idが紐づけでき、salariesテーブルのpaymentに月収が格納されています */
SELECT emp.id,
  SUM(sa.payment),
  AVG(sa.payment)
FROM employees AS emp
  INNER JOIN salaries AS sa ON sa.employee_id = emp.id
WHERE emp.age < 40
GROUP BY emp.id
HAVING AVG(sa.payment) > 7000000;

/* 5. customer毎に、order_amountの合計値を計算してください。
 
 customersテーブルとordersテーブルは、idカラムとcustomer_idカラムで紐づけができます
 
 ordersテーブルのorder_amountの合計値を取得します。
 
 SELECTの対象カラムに副問い合わせを用いて値を取得してください。*/
DESCRIBE customers;

SELECT *
FROM customers;

SELECT *
FROM orders;

SELECT id,
  (
    SELECT SUM(order_amount)
    FROM orders
    WHERE orders.customer_id = customers.id
  ) AS "合計値"
FROM customers;

/* 6. customersテーブルからlast_nameに田がつくレコード、
 
 ordersテーブルからorder_dateが2020-12-01以上のレコード、
 
 storesテーブルからnameが山田商店のレコード同士を連結します
 
 customersとorders, ordersとitems, itemsとstoresが紐づきます。
 
 first_nameとlast_nameの値を連結(CONCAT)して集計(GROUP BY)し、そのレコード数をCOUNTしてください。*/
SELECT COUNT(*),
  CONCAT(customers.last_name, customers.first_name)
FROM (
    SELECT *
    FROM customers
    WHERE last_name LIKE "%田%"
  ) AS customers
  INNER JOIN (
    SELECT *
    FROM orders
    WHERE order_date >= "2020-12-01"
  ) AS orders ON customers.id = orders.customer_id
  INNER JOIN items ON items.id = orders.item_id
  INNER JOIN (
    SELECT *
    FROM stores
    WHERE `name` = "山田商店"
  ) AS stores ON stores.id = items.store_id
GROUP BY CONCAT(customers.last_name, customers.first_name);

/* 7. salariesのpaymentが9,000,000よりも大きいものが存在するレコードを、employeesテーブルから取り出してください。
 
 employeesテーブルとsalariesテーブルを紐づけます。
 
 EXISTSとINとINNER JOIN、それぞれの方法で記載してください */
SELECT *
FROM employees AS e
WHERE EXISTS (
    SELECT 1
    FROM salaries AS s
    WHERE s.employee_id = e.id
      AND s.payment > 9000000
  );

SELECT *
FROM employees AS e
WHERE e.id IN(
    SELECT employee_id
    FROM salaries
    WHERE payment > 9000000
  );

SELECT DISTINCT e.*
FROM employees AS e
  INNER JOIN salaries AS s ON e.id = s.employee_id
WHERE s.payment > 9000000;

/* 8. employeesテーブルから、salariesテーブルと紐づけのできないレコードを取り出してください。
 
 EXISTSとINとLEFT JOIN、それぞれの方法で記載してください */
SELECT *
FROM employees AS e
WHERE NOT EXISTS (
    SELECT 1
    FROM salaries AS s
    WHERE s.employee_id = e.id
  );

SELECT *
FROM employees AS e
WHERE e.id NOT IN(
    SELECT employee_id
    FROM salaries
  );

SELECT e.*
FROM employees AS e
  LEFT JOIN salaries AS s ON e.id = s.employee_id
WHERE s.id IS NULL;

/* 9. employeesテーブルとcustomersテーブルのage同士を比較します
 
 customersテーブルの最小age, 平均age, 最大ageとemployeesテーブルのageを比較して、
 
 employeesテーブルのageが、最小age未満のものは最小未満、最小age以上で平均age未満のものは平均未満、
 
 平均age以上で最大age未満のものは最大未満、それ以外はその他と表示します
 
 WITH句を用いて記述します */
WITH customers_age AS (
  SELECT MAX(age) AS coustomers_max_age,
    MIN(age) AS coustomers_min_age,
    AVG(age) AS coustomers_avg_age
  FROM customers
)
SELECT *,
  CASE
    WHEN emp.age < ca.coustomers_min_age THEN "最小未満"
    WHEN emp.age < ca.coustomers_avg_age THEN "平均未満"
    WHEN emp.age < ca.coustomers_avg_age THEN "最大未満"
    ELSE "その他"
  END AS "customersとの比較"
FROM employees AS emp
  CROSS JOIN customers_age AS ca;

/* 10. customersテーブルからageが50よりも大きいレコードを取り出して、ordersテーブルと連結します。
 
 customersテーブルのidに対して、ordersテーブルのorder_amount*order_priceのorder_date毎の合計値。
 
 合計値の7日間平均値、合計値の15日平均値、合計値の30日平均値を計算します。
 
 7日間平均、15日平均値、30日平均値が計算できない区間(対象よりも前の日付のデータが十分にない区間)は、空白を表示してください。*/
WITH bigest_50_age_customers AS (
  SELECT id
  FROM customers
  WHERE age > 50
),
tmp_customers_orders AS (
  SELECT tc.id,
    od.order_date,
    SUM(od.order_price * od.order_price) AS payment,
    ROW_NUMBER() OVER (
      PARTITION BY tc.id
      ORDER BY od.order_date
    ) AS row_num
  FROM bigest_50_age_customers AS tc
    INNER JOIN orders AS od ON tc.id = od.customer_id
  GROUP BY tc.id,
    od.order_date
)
SELECT id,
  order_date,
  payment,
  row_num,
  CASE
    WHEN row_num < 7 THEN ""
    ELSE AVG(payment) OVER (
      PARTITION BY id
      ORDER BY order_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    )
  END AS "7日の平均",
  CASE
    WHEN row_num < 15 THEN ""
    ELSE AVG(payment) OVER (
      PARTITION BY id
      ORDER BY order_date ROWS BETWEEN 14 PRECEDING AND CURRENT ROW
    )
  END AS "15日の平均",
  CASE
    WHEN row_num < 30 THEN ""
    ELSE AVG(payment) OVER (
      PARTITION BY id
      ORDER BY order_date ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
    )
  END AS "30日の平均"
FROM tmp_customers_orders;