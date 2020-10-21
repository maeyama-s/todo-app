require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @task = FactoryBot.build(:task)
  end

  describe 'タスクの保存' do
    context "タスクが保存できる場合" do
      it "タイトルと詳細と期限とカテゴリーと優先度があればタスクは保存される" do
        expect(@task).to be_valid
      end
      it "タイトルのみあればタスクは保存される" do
        @task.details = ""
        @task.deadline = ""
        @task.category_id = ""
        @task.priority_id = ""
        expect(@task).to be_valid
      end
    end
    context "タスクが保存できない場合" do
      it "ユーザーが紐付いていないとタスクは保存できない" do
        @task.user = nil
        @task.valid?
        expect(@task.errors.full_messages).to include("Userを入力してください")
      end
      it "タイトルがないとタスクは保存できない" do
        @task.title = ""
        @task.valid?
        expect(@task.errors.full_messages).to include("タイトルを入力してください")
      end
    end
  end
end
