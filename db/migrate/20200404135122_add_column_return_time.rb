class AddColumnReturnTime < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :return_time, :datetime
  end
end
