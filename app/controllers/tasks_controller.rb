class TasksController < ApplicationController
  def index
    # タスク一覧表示させる
    @tasks = Task.all
  end

  def new
    # form_withに渡す引数（空のインスタンスをform_withで利用する）
    @task = Task.new
  end

  def create
    Task.create(task_params)
    redirect_to root_path
  end

  # Classの外部から呼ばれたら困るメソッドを隔離、可読性向上
  private
  # 指定したキーを持つパラメーターのみを受け取るように制限する
  def task_params
    params.require(:task).permit(:title, :details, :deadline, :category_id, :priority_id)
  end
end
