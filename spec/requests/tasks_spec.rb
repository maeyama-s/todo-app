require 'rails_helper'

RSpec.describe TasksController, type: :request do

  before do
    @task = FactoryBot.create(:task)
  end

  describe "GET #top" do
    it "topアクションにリクエストすると正常にレスポンスが返ってくる" do
      get root_path
      expect(response.status).to eq 200
    end
    it "topアクションにリクエストするとレスポンスにアプリ名が存在する" do
      get root_path
      expect(response.body).to include "ToDo App"
    end
    it "topアクションにリクエストするとレスポンスにログインリンクが存在する" do
      get root_path
      expect(response.body).to include "ログイン"
    end
    it "topアクションにリクエストするとレスポンスに新規登録リンクが存在する" do
      get root_path
      expect(response.body).to include "新規登録"
    end
  end
end