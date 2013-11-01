class AddIndexToActivity < ActiveRecord::Migration

  	def change
   
  	end

	add_index :activities, :user_id
   	add_index :activities, :room_id

end
