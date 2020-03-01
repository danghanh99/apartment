class AddPictureToHomes < ActiveRecord::Migration[5.1]
  def change
    add_column :homes, :picture, :string
  end
end
