class CreateHomes < ActiveRecord::Migration[5.1]
  def change
    create_table :homes do |t|
      t.references :user, foreign_key: true
      t.text :name
      t.text :status
      t.integer :number_floors
      t.integer :price

      t.timestamps
    end
    add_index :homes, [:user_id, :created_at]
  end
end
