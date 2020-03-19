class ChangeOrderStatusDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:orders, :order_status, from: "ordering", to: "requesting")
  end
end
