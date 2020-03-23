class AddRoomIdColumnToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :room, foreign_key: true
  end
end
