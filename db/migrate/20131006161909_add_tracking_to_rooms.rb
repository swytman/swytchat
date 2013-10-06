class AddTrackingToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :users, :text, :limit => nil
  end
end
