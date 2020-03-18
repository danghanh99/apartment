class AddColumnToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :name, :string
    add_column :orders, :address, :text
    add_column :orders, :phone_number, :integer
  end
end
