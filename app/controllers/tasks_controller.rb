class TasksController < ApplicationController
  # tasksコントローラーのindexアクション以外にアクセスしようとするログインしていないユーザーはログインページへ遷移される。
  before_action :authenticate_user!, except: :index

  def index
    # タスク一覧表示させる(新規投稿順に並ぶように記述)
    @tasks = Task.order("created_at DESC")
  end

  def new
    # form_withに渡す引数（空のインスタンスをform_withで利用する）
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  # Classの外部から呼ばれたら困るメソッドを隔離、可読性向上
  private
  # 指定したキーを持つパラメーターのみを受け取るように制限する
  def task_params
    params.require(:task).permit(
      :title, :details, :deadline, :category_id, :priority_id
    ).merge(user_id: current_user.id)
  end
end
