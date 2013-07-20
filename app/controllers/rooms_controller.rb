class RoomsController < ApplicationController
   

  def new
  	@room = Room.new
  end

def index
      @rooms = Room.paginate(page: params[:page])
  end

  def show
    @room = Room.find(params[:id])
    session[:room_id] = @room.id
    @messages = @room.messages
    @message = Message.new
   end

def create
 @room = Room.new( params[:room] )
  @room.no_pass?

 if @room.save
    flash[:success] = "Добро пожаловать в #{@room.name}"
     redirect_to room_path @room.id
    else
     render 'new'
    end
end

def sendnew
 
  @messages = Message.where("room_id = ? AND id > ?",
   params[:id], params[:last_message_id])
  #response.headers['Content-type'] = "text/plain; charset=utf-8"
    
  respond_to do |format|
      format.json { 
            render :json=>@messages.map { 
            |message| 
            {
            :id => message.id,
            :name => message.user.name,
            :content => message.content,
            :time => message.created_at.strftime("%d-%m-%Y %H:%M:%S") }
            }
      }
    end
end

 

end
