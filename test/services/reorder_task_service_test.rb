require "test_helper"

class ReorderTaskServiceTest < ActiveSupport::TestCase

  test "task to move with order number originally at 1 then is moved to order number 3" do
    task_to_move = Task.new :content => 'Buy grocery', :order_number => 1
    target_order_number = 3
    service = ReorderTaskService.new
    service.move_up_tasks_above_target task_to_move, target_order_number
    assert_equal 3, task_to_move.order_number
  end

end