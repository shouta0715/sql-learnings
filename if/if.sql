SELECT name,
  IF(age < 20, "未成年", "成人")
FROM users;

SELECT *,
  CASE
    birth_place
    WHEN "日本" THEN "日本人"
    WHEN "Iraq" THEN "イラク人"
    ELSE "外国人"
  END AS "国籍"
FROM users;

SELECT name,
  CASE
    WHEN name IN ("香川県", "愛媛県", "徳島県", "高知県") THEN "四国"
    WHEN name IN ("東京都", "神奈川県", "埼玉県", "千葉県") THEN "関東"
    WHEN name IN ("大阪府", "京都府", "兵庫県", "奈良県", "滋賀県", "和歌山県") THEN "関西"
    WHEN name IN ("北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県") THEN "東北"
    WHEN name IN ("愛知県", "岐阜県", "静岡県", "三重県") THEN "中部"
    WHEN name IN ("福岡県", "佐賀県", "長崎県", "大分県", "熊本県", "宮崎県", "鹿児島県") THEN "九州"
    ELSE "その他"
  END AS "地域"
FROM prefectures;