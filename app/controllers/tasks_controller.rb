class TasksController < ApplicationController

  def index
    @tasks = Task.all
    render json: @tasks
  end

  def show
    @task = Task.find(params[:id])
    render json: @task
  end

  def create
    @new_task = Task.create(
      content: params[:content],
      order_number: params[:order_number]
    )
    render json: @new_task
  end

  def update
    @task = Task.find(params[:id])
    @task.update(
      content: params[:content],
      order_number: params[:order_number]
    )
    render json: @task
  end

  def destroy
    @tasks = Task.all
    @deleted_task = Task.find(params[:id])
    @deleted_task.destroy
    render json: @tasks
  end

end
