class AddNoPassToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :no_pass, :boolean, default: false
  end
end
