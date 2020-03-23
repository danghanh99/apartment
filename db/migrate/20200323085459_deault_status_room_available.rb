class DeaultStatusRoomAvailable < ActiveRecord::Migration[5.1]
  def change
    change_column :rooms, :status, :string, default: "available "
  end
end
