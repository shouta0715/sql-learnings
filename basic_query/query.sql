-- INSERT
INSERT INTO people
VALUES (1, "name", "2002-0703");

-- INSERT (特定のカラムのみ)
INSERT INTO people (id, name)
VALUES (2, "name 2");

--　特定のカラムのみ取得
SELECT name
FROM people;

-- 特定条件にあうものを取得
SELECT *
FROM users
WHERE id = 1;

-- UPDATE
UPDATE people
SET name = "name"
WHERE id = 2;

-- DELETE 
DELETE FROM users
WHERE id = 1;

-- DISTINCT (重複を削除 複数の場合はANDです。)
SELECT DISTINCT name,
  birth_day
FROM people;

-- ORDER BY (並び替え)
SELECT *
FROM people
ORDER BY id DESC;

-- 複数の場合は、まず、１つ目で並べられる。次に、１つ目のカラムが同じ値の中で2個目のカラムが並び替えられる。もし、1つめのカラムの値が違った場合、たとえ２目のカラムの順番が違っても、並び替えられない。
SELECT *
FROM people
ORDER BY birth_day,
  age DESC;

-- LIMITとOFFSET (取得する数を制限と、取得する場所を指定する。)
SELECT *
FROM people
ORDER BY id DESC
LIMIT 10 OFFSET 1;

-- TRUNCATE (テーブルの中身を削除する。)
TRUNCATE people;