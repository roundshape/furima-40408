# テーブル設計

## users テーブル

| Column                 | Type     | Options                   |
| ---------------------- | -------- | ------------------------- |
| nickname               | string   | null: false               |
| email                  | string   | null: false, unique: true |
| password               | string   | null: false               |
| first_name             | string   | null: false               |
| last_name              | string   | null: false               |
| first_kana             | string   | null: false               |
| last_kana              | string   | null: false               |
| birthday               | datetime | null: false               |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| category    | string     | null: false                    |
| name        | string     | null: false                    |
| detail      | string     | null: false                    |
| price       | integer    | null: false                    |
| condition   | string     | null: false                    |
| ship_resp   | string     | null: false                    |
| ship_from   | string     | null: false                    |
| ship_period | integer    | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase
- has_one_attached :image

## purchases テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| item       | references | null: false, foreign_key: true |
| user       | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :delivery

## deliveries テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| post_code  | string     | null: false                    |
| prefecture | string     | null: false                    |
| city       | string     | null: false                    |
| address    | string     | null: false                    |
| building   | string     |                                |
| phone      | string     | null: false                    |
| purchase   | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase
