class Task < ApplicationRecord
  # Taskクラスに記述する事で、belongs_to_active_hashメソッドを使用できる。
  extend ActiveHash::Associations::ActiveRecordExtensions
  # ActiveHashを使って作成したモデルに対してアソシエーションを設定する場合は、belongs_to_active_hashメソッドを使う。
  belongs_to_active_hash :category
  belongs_to_active_hash :priority

  #プルダウンの選択が「--」(id:1)の時は保存できないようにする
  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :priority_id
  end

  # 各項目のバリデーション
  with_options presence: true do
    validates :title
    validates :category_id
    validates :priority_id
  end

  # 他テーブルとのアソシエーション
  belongs_to :user
end
