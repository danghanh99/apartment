class DropColumnRequestRentalPreiodRequestCheckinTime < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :request_rental_preiod
    remove_column :orders, :request_checkin_time
  end
end
