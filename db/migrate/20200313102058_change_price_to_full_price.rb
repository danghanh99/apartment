class ChangePriceToFullPrice < ActiveRecord::Migration[5.1]
  def change
    rename_column :homes, :price, :full_price
  end
end
