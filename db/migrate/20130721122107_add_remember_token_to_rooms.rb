class AddRememberTokenToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :remember_token, :string
  end
end
