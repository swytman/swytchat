class MessagesController < ApplicationController
before_filter :signed_in_user,
                only: [:create] 

def create


 @message = Message.new(params[:message]) 
  @message.room_id=session[:room_id]
  @message.user_id=session[:user_id]
  @message.save
 respond_to do |format|
 format.html {redirect_to room_path session[:room_id]}
   format.json {render json: @message}
   	end
   
   end


	


end
