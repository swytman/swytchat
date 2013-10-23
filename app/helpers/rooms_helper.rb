module RoomsHelper

	def save_room_token (room)
		
		cookies.permanent["#{room.id}token"]= { :value => room.remember_token, :expires => Time.now + 3600}
	end

	def check_room_token (room)
		@r = Room.find_by_remember_token(cookies["#{room.id}token"])
		return ( !@r.nil? && @r.id == room.id)
	end

def create_remember_token
      return remember_token = SecureRandom.urlsafe_base64
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
		    return 100.year.ago
		end
	end

	def update_tracking (trackjson, user, status)
		if trackjson == nil
			json = {user => {:status => status, :time => Time.now.strftime("%H:%M:%S")}}.to_json
			return json
		end

		h = JSON.parse(trackjson)
		h[user] = {:status => status, :time => Time.now.strftime("%H:%M:%S")}
		
		return h.to_json
		
	

	end

end