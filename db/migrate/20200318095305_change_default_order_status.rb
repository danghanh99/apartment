class ChangeDefaultOrderStatus < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :status, :string, default: "ordering"
  end
end
