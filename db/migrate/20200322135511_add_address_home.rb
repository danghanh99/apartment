class AddAddressHome < ActiveRecord::Migration[5.1]
  def change
    add_column :homes, :address, :text
  end
end
