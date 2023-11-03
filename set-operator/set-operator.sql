SELECT *
FROM new_students
UNION
SELECT *
FROM students;

SELECT COUNT(*)
FROM customers;

SELECT COUNT(name)
FROM customers;

SELECT COUNT(name)
FROM customers
WHERE id > 80;

SELECT age,
  COUNT(*),
  MAX(birth_day),
  MIN(birth_day)
FROM users
WHERE birth_place = "日本"
GROUP BY age
ORDER BY age;

SELECT department,
  SUM(salary),
  FLOOR(AVG(salary))
FROM employees
WHERE age = 40
GROUP BY department;

SELECT CASE
    WHEN birth_place = "日本" THEN "日本人"
    ELSE "その他"
  END AS "国籍",
  COUNT(*),
  MAX(age)
FROM users
GROUP BY CASE
    WHEN birth_place = "日本" THEN "日本人"
    ELSE "その他"
  END;

SELECT CASE
    WHEN name IN("香川県", "愛媛県", "徳島県", "高知県") THEN "四国"
    ELSE "その他"
  END AS "地域名",
  COUNT(*)
FROM prefectures
GROUP BY CASE
    WHEN name IN("香川県", "愛媛県", "徳島県", "高知県") THEN "四国"
    ELSE "その他"
  END