module MessagesHelper

	def create_custom_message (content, user_id, room_id)
		@message = Message.new(content: content)
		@message.user_id = user_id
		@message.room_id = room_id
    	@message.save

    end


end
