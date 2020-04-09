class AddColumnToRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :request_rental_preiod, :integer
    add_column :orders, :request_checkin_time, :datetime
  end
end
