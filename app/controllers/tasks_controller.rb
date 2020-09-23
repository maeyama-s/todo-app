class TasksController < ApplicationController
  def index
  end

  def new
    # form_withに渡す引数（空のインスタンス）
    @task = Task.new
  end
end
