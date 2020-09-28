# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

#

# テーブル設計

## usersテーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | primary key |
| encrypted_password | string | null: false |

### Association

- has_many :tasks

## tasksテーブル

| Column      | Type       | Options           |
| ----------- | ---------- | ----------------- |
| user        | references | foreign_key: true |
| title       | string     | null: false       |
| details     | text       |                   |
| deadline    | date       |                   |
| category_id | integer    |                   |
| priority_id | integer    |                   |

### Association

- belongs_to :user

#

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
