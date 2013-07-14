class AddSaltToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :salt, :string
  end
end
