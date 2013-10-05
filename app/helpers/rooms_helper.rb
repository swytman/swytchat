module RoomsHelper

	def save_room_token (room)
		cookies.permanent["#{room.id}token"]= room.remember_token
	end

	def check_room_token (room)
		@r = Room.find_by_remember_token(cookies["#{room.id}token"])
		return ( !@r.nil? && @r.id == room.id)
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


end