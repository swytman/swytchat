module RoomsHelper

	def save_room_token (room)
		
		cookies.permanent["#{room.id}token"]= { :value => room.remember_token, :expires => Time.now + 3600}
	end

	def check_room_token(id)
		if Room.find_by_id(id).no_pass then
		 return true 
		end
		@r = Room.find_by_remember_token(cookies["#{id}token"])
		return ( !@r.nil? && @r.id == id)
	end

def create_remember_token
      return remember_token = SecureRandom.urlsafe_base64
    end

def only_owner
	if !is_owner?
		flash[:error] = "Нет прав"
     	redirect_back_or root_path
    end
end


def is_owner?
 @room = current_user.rooms.find_by_id(params[:id])
    if @room.nil? #only author can edit a room
    	return false
    else
    	return true
    end
end


	def date_from (period)

		case period
		when '1'
		    return 1.day.ago
		when '2'
		    return 1.week.ago
		when '3'
		    return 1.month.ago
		when '4'
		    return 100.year.ago
		else
		    return 1.week.ago
		end
	end


	def ClearOld (json)
		return ''
	end

end