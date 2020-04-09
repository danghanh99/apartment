class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.references :order, foreign_key: true
      t.references :user, foreign_key: true
      t.references :home, foreign_key: true
      t.integer :length
      t.integer :width
      t.integer :height
      t.integer :number_room
      t.integer :price
      t.string :price_unit
      t.string :status
      t.integer :area

      t.timestamps
    end
    add_index :rooms, [:user_id, :created_at]
  end
end
