class TasksController < ApplicationController
  # tasksコントローラーのindexアクション以外にアクセスしようとするログインしていないユーザーはログインページへ遷移される。
  before_action :authenticate_user!, except: :top

  def top
  end

  def index
    # タスク一覧表示させる(期限順に並ぶように記述)
    @tasks = Task.where(user_id: current_user.id).order('deadline ASC')
    @today = @tasks.where(deadline: Date.today)
    @expired = @tasks.where('deadline < ?', Date.today)
    @far_away = @tasks.where('deadline > ?', Date.today)
  end

  def new
    # form_withに渡す引数（空のインスタンスをform_withで利用する）
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  # JSでタスク作成
  def create_task
    task = Task.create(title: params[:title])
    render json:{task: task}
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update(task_params)
    redirect_to tasks_path
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_path
  end

  def repeat
    task = Task.find(params[:id])
    task = Task.create(
                    user_id: task.user_id, title: task.title, details: task.details, deadline: task.deadline + 1,
                    category_id: task.category_id, priority_id: task.priority_id
                  )
    redirect_to tasks_path
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
