class ChangeHomesStatus < ActiveRecord::Migration[5.1]
  def change
    change_column :homes, :status, :string
  end
end
