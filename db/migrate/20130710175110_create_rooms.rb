class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :password_digest
      t.timestamps
    end

    add_index :rooms, :name
  end
end
