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

end
