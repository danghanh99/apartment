class ChangeHomesName < ActiveRecord::Migration[5.1]
  def change
    change_column :homes, :name, :string
  end
end
