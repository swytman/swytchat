module ActivitiesHelper
@@slogger ||= Logger.new("#{Rails.root}/log/swytchat.log")

def create_or_update_time (user_id, room_id)
	@activity = Activity.where("room_id = ? AND user_id = ?", room_id, user_id)

	@@slogger.info ("create_or_update_time: find #{@activity.first==nil} 
		by room_id=#{room_id} and user_id=#{user_id}")

@@slogger.info ("IS IT NIL #{@activity.first == nil}")
		if @activity.first == nil
			@@slogger.info ("Try to create #{room_id}")
			@@slogger.info (@activity = Activity.create(:name => User.find(current_user.id).name,
			 :room_id => room_id, :user_id =>  user_id, :time => Time.now))
			@activity.save!
		else
			@@slogger.info ("Try to update #{room_id}")
			@activity.first.update_attributes({time:Time.now})
			@activity.first.save!
		end
	
end	


end
