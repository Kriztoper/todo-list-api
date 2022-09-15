require "test_helper"

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "create new task to buy grocery then created task should be buy grocery" do
    new_task = Task.new :content => 'Buy grocery', :order_number => 1
    assert_equal 'Buy grocery', new_task.content
  end

end
