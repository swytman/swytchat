class CreateAttachFiles < ActiveRecord::Migration
  def change
    create_table :attach_files do |t|
      t.integer :user_id
      t.integer :room_id
      t.has_attached_file :file    

      t.timestamps
    end
  end
end
