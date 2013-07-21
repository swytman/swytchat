module RoomsHelper

	def save_room_token (room)
		cookies.permanent["#{room.id}token"]= room.remember_token
	end

	def check_room_token (room)
		@r = Room.find_by_remember_token(cookies["#{room.id}token"])
		return ( !@r.nil? && @r.id == room.id)
	end

end
