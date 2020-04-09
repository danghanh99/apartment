class DeleteOrderStatus < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :order_status
  end
end
