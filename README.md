# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| name               | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |

### Association

- has_many :items
- has_many :purchases
- has_many :deliveries

## items テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| name        | string     | null: false                    |
| price       | integer    | null: false                    |
| user_id     | references | null: false, foreign_key: true |
| purchase_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :item

## purchases テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| item_id    | references | null: false, foreign_key: true |
| delivery_id| references | null: false, foreign_key: true |
| user_id    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :delivery

## deliveries テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| address | string     | null: false                    |
| user_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :purchases
