SELECT *
FROM employees AS em
WHERE EXISTS(
    SELECT 1
    FROM departments AS dt
    WHERE dt.id = em.department_id
  );

SELECT *
FROM customers AS c1
WHERE EXISTS (
    SELECT *
    FROM customers_2 AS c2
    WHERE c1.first_name = c2.first_name
      AND c1.last_name = c2.last_name
      AND(
        c1.phone_number = c2.phone_number
        OR(
          c1.phone_number IS NULL
          AND c2.phone_number IS NULL
        )
      )
  );

SELECT *
FROM customers AS c1
WHERE NOT EXISTS (
    SELECT *
    FROM customers_2 AS c2
    WHERE c1.id = c2.id
      AND c1.first_name = c2.first_name
      AND c1.last_name = c2.last_name
      AND(
        c1.phone_number = c2.phone_number
        OR(
          c1.phone_number IS NULL
          AND c2.phone_number IS NULL
        )
      )
      AND c1.age = c2.age
  );

SELECT *
FROM customers AS c1
WHERE EXISTS (
    SELECT *
    FROM customers_2 AS c2
    WHERE c1.id = c2.id
      AND c1.first_name = c2.first_name
      AND c1.last_name = c2.last_name
      AND(
        c1.phone_number = c2.phone_number
        OR(
          c1.phone_number IS NULL
          AND c2.phone_number IS NULL
        )
      )
      AND c1.age = c2.age
  );