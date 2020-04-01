class AddColumnOrderType < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :order_type, :string
    add_column :orders, :relation, :string
  end
end
