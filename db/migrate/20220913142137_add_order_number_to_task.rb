class AddOrderNumberToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :order_number, :integer
  end
end
