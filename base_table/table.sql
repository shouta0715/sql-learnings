-- テーブルの作成
CREATE TABLE users (
  id INT PRIMARY KEY,
  name VARCHAR(10),
  age INT,
  phone_number CHAR(13),
  message TEXT
);

-- テーブルの作成
DROP TABLE users;

-- テーブルの定義を確認
DESCRIBE users;

-- テーブルの確認
SHOW TABLES;

-- テーブル名の変更
ALTER TABLE users
  RENAME TO new_users;

-- カラムの消去
ALTER TABLE new_users DROP COLUMN message;

-- カラムの追加
ALTER TABLE new_users
ADD COLUMN message TEXT;

-- 任意のカラムにデータを追加
ALTER TABLE new_users
ADD COLUMN gender CHAR(1)
AFTER age;

-- カラムの定義を変更
ALTER TABLE new_users
MODIFY name VARCHAR(50);

-- カラムの名前を変更
ALTER TABLE new_users CHANGE COLUMN name full_name VARCHAR(200);

-- Primary Keyの削除
ALTER TABLE new_users DROP PRIMARY KEY;

-- Primary Keyの追加
ALTER TABLE new_users
ADD PRIMARY KEY(id);