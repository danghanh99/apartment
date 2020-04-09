class ChangeOrderStatusToStatus < ActiveRecord::Migration[5.1]
  def change
    rename_column :orders, :order_status, :status
  end
end
