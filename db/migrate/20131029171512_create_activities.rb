class CreateActivities < ActiveRecord::Migration
  	
  	def change
	    create_table :activities do |t|
      t.integer :room_id
      t.integer :user_id
      t.datetime :time
      t.timestamps
    end
	add_index :activities, [:room_id, :user_id], unique: true
  end
end
