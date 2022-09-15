class ReorderTaskService

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