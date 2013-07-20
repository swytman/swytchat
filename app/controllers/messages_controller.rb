class MessagesController < ApplicationController

def create
 @message = Message.new(params[:message]) 
   @message.room_id=session[:room_id]
   @message.user_id=session[:user_id]
   if @message.save
    
     redirect_to room_path session[:room_id]
   else
   flash[:success] = session[:user_id]
   redirect_to room_path session[:room_id]
   		end
   end


	


end
