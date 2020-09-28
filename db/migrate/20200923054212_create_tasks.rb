class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :user,     foreign_key: true
      t.string :title,        null: false
      t.text :details
      t.date :deadline
      t.integer :category_id
      t.integer :priority_id
      t.timestamps
    end
  end
end
