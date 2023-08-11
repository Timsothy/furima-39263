# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## usersテーブル

| Column             | Type    | Options                  |
| ------------------ | ------- | ------------------------ |
| nickname           | string  | null: false              |
| email              | string  | null: false, unique:true |
| encrypted_password | string  | null: false              |
| last_name          | string  | null: false              |
| first_name         | string  | null: false              |
| last_name_kana     | string  | null: false              |
| first_name_kana    | string  | null: false              |
| birth_date         | date    | null: false              |

### Association

- has_many :items
- has_many :comments


## itemsテーブル

| Column                   | Type       | Options                       |
| ------------------------ | ---------- | ----------------------------- |
| item_image               | string     | null: false                   |
| item_name                | string     | null: false                   |
| item_info                | text       | null: false                   |
| item_category            | string     | null: false                   |
| item_sales_status        | string     | null: false                   |
| item_shipping_fee_status | string     | null: false                   |
| item_prefecture          | string     | null: false                   |
| item_scheduled_delivery  | string     | null: false                   |
| item_price               | integer    | null: false                   |
| user                     | references | null: false foreign_key: true |

### Association

- has_many   :comments
- has_one    :oder
- belongs_to :user

## ordersテーブル

| Column       | Type       | Options                       |
| ------------ | ---------- | ----------------------------- |
| postal_code  | string     | null: false                   |
| prefecture   | string     | null: false                   |
| city         | string     | null: false                   |
| addresses    | string     | null: false                   |
| building     | string     | null: false                   |
| phone_number | string     | null: false                   |
| item         | references | null: false foreign_key: true |

### Association

- belongs_to :item

