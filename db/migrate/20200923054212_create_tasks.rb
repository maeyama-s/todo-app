class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :user,     foreign_key: true
      t.string :title,        null: false
      t.string :details
      t.date :deadline
      t.integer :category_id, null: false
      t.integer :priority_id, null: false
      t.timestamps
    end
  end
end
