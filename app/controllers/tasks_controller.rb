class TasksController < ApplicationController

  def index
    @tasks = Task.all
    render json: @tasks
  end

  def create
    @newTask = Task.create(
      content: params[:content]
    )
    render json: @newTask
  end

  def update
    @task = Task.find(params[:id])
    @task.update(
      content: params[:content]
    )
    render json: @task
  end

end
