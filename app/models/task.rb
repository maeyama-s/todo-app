class Task < ApplicationRecord
  # Taskクラスに記述する事で、belongs_to_active_hashメソッドを使用できる。
  extend ActiveHash::Associations::ActiveRecordExtensions
  # ActiveHashを使って作成したモデルに対してアソシエーションを設定する場合は、belongs_to_active_hashメソッドを使う。
  belongs_to_active_hash :category
  belongs_to_active_hash :priority

  # 各項目のバリデーション
  with_options presence: true do
    validates :title
  end

  # 他テーブルとのアソシエーション
  belongs_to :user
end
