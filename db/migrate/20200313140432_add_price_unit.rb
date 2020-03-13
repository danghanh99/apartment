class AddPriceUnit < ActiveRecord::Migration[5.1]
  def change
    add_column :homes, :price_unit, :string, default: "VND"
  end
end
