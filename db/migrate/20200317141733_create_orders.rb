class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :home, foreign_key: true
      t.datetime :checkin_time
      t.integer :rental_period
      t.string :order_status

      t.timestamps
    end
  end
end
