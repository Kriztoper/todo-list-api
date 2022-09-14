class TasksController < ApplicationController

  def index
    tasks = Task.all.sort_by { |t| t.order_number }
    render json: tasks, except: [:created_at, :updated_at]
  end

  def show
    task = Task.find(params[:id])
    render json: task, except: [:created_at, :updated_at]
  end

  def create
    new_task = Task.create(
      content: params[:content],
      order_number: params[:order_number]
    )
    render json: new_task
  end

  def update
    task = Task.find(params[:id])
    task.update(
      content: params[:content],
      order_number: params[:order_number]
    )
    render json: task
  end

  def destroy
    tasks = Task.all
    deleted_task = Task.find(params[:id])
    deleted_task.destroy
    render json: tasks, except: [:created_at, :updated_at]
  end

  # Scenario 1: small order_number task is moved to bigger order_number at the middle
  # given tasks:
  # [
  #     {
  #         "id": 1,
  #         "content": "Buy grocery",
  #         "order_number": 1
  #     },
  #     {
  #         "id": 2,
  #         "content": "Pay bills",
  #         "order_number": 2
  #     },
  #     {
  #         "id": 3,
  #         "content": "Laundry dirty clothes and bed sheet",
  #         "order_number": 3
  #     }
  # ]
  # then we want to move 1st task (task with order_number = 1) as 2nd task (task with order_number = 2)
  # Proposed solution: Since task to move is from smaller order_number then moved to bigger order_number,
  # the order_numbers below the target_order_number will be updated and reduced by 1, then the task to move's
  # order_number will be set as the target_order_number
  #
  # Scenario 2: bigger order_number task is moved to smaller order_number at the middle
  # given tasks:
  # [
  #     {
  #         "id": 1,
  #         "content": "Buy grocery",
  #         "order_number": 1
  #     },
  #     {
  #         "id": 2,
  #         "content": "Pay bills",
  #         "order_number": 2
  #     },
  #     {
  #         "id": 3,
  #         "content": "Laundry dirty clothes and bed sheet",
  #         "order_number": 3
  #     }
  # ]
  # then we want to move 3rd task (task with order_number = 3) as 2nd task (task with order_number = 2)
  # Proposed solution: Since task to move is from bigger order_number then moved to smaller order_number,
  # the order_numbers bigger than the target_order_number will be updated and increased by 1, then the task to move's
  # order_number will be set as the target_order_number
  def reorder
    task_to_move = Task.find(params[:this_id])
    target_order_number = params[:target_order_number].to_i
    if task_to_move.order_number < target_order_number
      move_up_tasks_above_target task_to_move, target_order_number
    elsif task_to_move.order_number > target_order_number
      move_down_tasks_below_target task_to_move, target_order_number
    end
    render json: task_to_move
  end

  private

  def move_up_tasks_above_target(task_to_move, target_order_number)
    from_range = task_to_move.order_number + 1
    to_range = target_order_number
    (from_range..to_range).each do |order_number|
      current_task = Task.where(order_number: order_number).first
      unless current_task.nil?
        current_task.update_column(:order_number, current_task.order_number - 1)
      end
    end
    task_to_move.update(order_number: target_order_number)
  end

  def move_down_tasks_below_target(task_to_move, target_order_number)
    from_range = target_order_number
    to_range = task_to_move.order_number - 1
    (from_range..to_range).each do |order_number|
      current_task = Task.where(order_number: order_number).first
      unless current_task.nil?
        current_task.update_column(:order_number, current_task.order_number + 1)
      end
    end
    task_to_move.update(order_number: target_order_number)
  end

end
