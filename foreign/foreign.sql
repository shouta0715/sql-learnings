CREATE TABLE schools (id INT PRIMARY KEY, name VARCHAR(255));

CREATE TABLE students (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  age INT,
  school_id INT,
  FOREIGN KEY (school_id) REFERENCES schools (id)
);

ALTER TABLES employees
ADD CONSTRAINT unique_employees_name UNIQUE(name);

SELECT *
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_NAME = "employees";

# UNIQUE
ALTER TABLES < テーブル名 >
ADD CONSTRAINT < UNIQUE 名 > UNIQUE(< カラム名 >);

ALTER TABLE < テーブル名 > DROP CONSTRAINT < UNIQUE 名 >
SELECT *
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_NAME = "<テーブル名>";

# DEFAULT
ALTER TABLE < テーブル名 > ALTER < カラム名 >
SET DEFAULT < DEFAULT 値 >;

# NOT NULL
ALTER TABLE < テーブル名 >
MODIFY < カラム名 > < 型 > NOT NULL;

# CEHCK
ALTER TABLE < テーブル名 >
ADD CONSTRAINT < カラム名 > CHECK(< 制約条件 >) # 主キー
ALTER TABLE < テーブル名 >
ADD PRIMARY KEY (< カラム名 >);

or
ALTER TABLE < テーブル名 >
ADD CONSTRAINT < 制約名 > PRIMARY KEY (< カラム名 >);

# 外部キー
ALTER TABLE < テーブル名 >
ADD CONSTRAINT < 制約名 > FOREIGN KEY (< カラム名 >) REFERENCES < 外部テーブル名 >(< 外部テーブルカラム名 >)