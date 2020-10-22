require 'rails_helper'

RSpec.describe "タスク作成", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @task_title = Faker::Name.initials(number: 5)
    @task_details = Faker::Name.initials(number: 10)
  end

  context 'タスク作成ができるとき'do
    it 'ログインしたユーザーはタスク作成できる' do
      # ログインする
      sign_in(@user)
      # タスク作成ページに移動する
      visit new_task_path
      # フォームに情報を入力する
      fill_in 'task_title', with: @task_title
      fill_in 'task_details', with: @task_details
      select "2025", from: "task_deadline_1i"
      select "12", from: "task_deadline_2i"
      select "31", from: "task_deadline_3i"
      select "プライベート", from: "task-category"
      select "重要度が高く、緊急度も高い", from: "task-priority"
      # 送信するとTaskモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Task.count }.by(1)
      # indexページに遷移することを確認する
      expect(current_path).to eq tasks_path
      # indexページには先ほど投稿した内容のタスクが存在することを確認する
      expect(page).to have_content(@task_title)
    end
  end
  context 'タスク作成ができないとき'do
    it 'ログインしていないとタスク作成ページに遷移できない' do
      # topページに遷移する
      visit root_path
      # タスク作成ページに移動しようとする
      visit new_task_path
      # ログインページに遷移されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe 'タスク編集', type: :system do
  before do
    @task = FactoryBot.create(:task)
  end

  context 'タスク編集ができるとき' do
    it 'ログインしたユーザーは自分が作成したタスクの編集ができる' do
      # タスクを作成したユーザーでログインする
      sign_in(@task.user)
      # タスクにリンクがあることを確認する
      have_link @task.title, href: task_path(@task)
      # 詳細ページへ遷移する
      visit task_path(@task)
      # 編集ページへ遷移する
      visit edit_task_path(@task)
      # すでに作成済みの内容がフォームに入っていることを確認する
      expect(
        find('#task_title').value
      ).to eq @task.title
      expect(
        find('#task_details').value
      ).to eq @task.details
      # 投稿内容を編集する
      fill_in 'task_title', with: "#{@task.title}+編集したテキスト"
      fill_in 'task_details', with: "#{@task.details}+編集したテキスト"
      # 編集してもTaskモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Task.count }.by(0)
      # indexページに遷移したことを確認する
      expect(current_path).to eq tasks_path
      # indexページには先ほど変更した内容のツイートが存在することを確認する
      expect(page).to have_content("#{@task.title}+編集したテキスト")
    end
  end
  context 'タスク編集ができないとき' do
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      # topページにいる
      visit root_path
      # タスク編集ページに移動しようとする
      visit edit_task_path(@task)
      # ログインページに遷移されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe 'タスク削除', type: :system do
  before do
    @task = FactoryBot.create(:task)
  end

  context 'タスク削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したタスクの削除ができる' do
      # タスクを投稿したユーザーでログインする
      sign_in(@task.user)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        page.first(".fa-check-circle").click
      }.to change { Task.count }.by(-1)
      # indexページに遷移したことを確認する
      expect(current_path).to eq tasks_path
      # indexページにはタスクの内容が存在しないことを確認する
      expect(page).to have_no_content("#{@task.title}")
    end
  end
  context 'タスク削除ができないとき' do
    it 'ログインしていないとタスクの削除ボタンがない' do
      # topページにいる
      visit root_path
      # indexページに移動しようとする
      visit tasks_path
      # ログインページに遷移されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe 'タスク詳細', type: :system do
  before do
    @task = FactoryBot.create(:task)
  end

  it 'ログインしたユーザーはタスク詳細ページに遷移してタスクの内容が表示される' do
    # タスクを投稿したユーザーでログインする
      sign_in(@task.user)
    # タスクにリンクがあることを確認する
    have_link @task.title, href: task_path(@task)
    # 詳細ページに遷移する
    visit task_path(@task)
    # 詳細ページにタスクの内容が含まれている
    expect(page).to have_content("#{@task.title}")
    expect(page).to have_content("#{@task.details}")
    expect(page).to have_content("#{@task.deadline}")
  end
  it 'ログインしていない状態でタスク詳細ページに遷移できない' do
    # topページにいる
    visit root_path
    # indexページに移動しようとする
    visit tasks_path
    # ログインページに遷移されることを確認する
    expect(current_path).to eq new_user_session_path
  end
end

RSpec.describe "非同期でタスク作成", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @task_title = Faker::Name.initials(number: 5)
  end

  context '非同期でタスク作成ができるとき'do
    it 'ログインしたユーザーは非同期でタスク作成できる' do
      # ログインする
      sign_in(@user)
      # indexページに遷移されることを確認する
      expect(current_path).to eq tasks_path
      # フォームに情報を入力する
      fill_in 'title', with: @task_title
      # 送信ボタンをクリックする
        find('input[name="commit"]').click
      # indexページにいることを確認する
      expect(current_path).to eq tasks_path
      # indexページには先ほど投稿した内容のタスクが存在することを確認する
      expect(page).to have_content(@task_title)
    end
  end
  context '非同期でタスク作成ができないとき'do
    it 'ログインしていないと非同期でタスク作成できない' do
      # topページに遷移する
      visit root_path
      # indexページに移動しようとする
      visit tasks_path
      # ログインページに遷移されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe 'タスク複製', type: :system do
  before do
    @task = FactoryBot.create(:task)
  end

  context 'タスク複製ができるとき' do
    it 'ログインしたユーザーは自らが投稿したタスクの複製ができる' do
      # タスクを投稿したユーザーでログインする
      sign_in(@task.user)
      # 投稿を複製するとレコードの数が1増えることを確認する
      expect{
        page.first(".fa-redo-alt").click
      }.to change { Task.count }.by(1)
      # indexページに遷移したことを確認する
      expect(current_path).to eq tasks_path
      # indexページにはタスクの内容が存在することを確認する
      expect(page).to have_content("#{@task.title}")
    end
  end
  context 'タスク複製ができないとき' do
    it 'ログインしていないとタスクの複製ボタンがない' do
      # topページにいる
      visit root_path
      # indexページに移動しようとする
      visit tasks_path
      # ログインページに遷移されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end