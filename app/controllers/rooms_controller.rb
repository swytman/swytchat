class RoomsController < ApplicationController
 before_filter :signed_in_user,
                only: [:index, :show, :new]    

  

  def new
  	@room = Room.new
  end

def index
      @rooms = Room.paginate(page: params[:page])
  end
def password_request


end

def password_check
  room = Room.find(params[:id])
   if (room && room.authenticate(params[:room][:password].to_s))
     save_room_token room
     redirect_to room_path (room)
   else
      flash[:error] = 'Неверный пароль'
      redirect_to password_request_room_path(room)
    end

end



  def show
    @room = Room.find(params[:id])

        if !@room.no_pass then
          if !check_room_token (@room) then
            redirect_to password_request_room_path(@room)
           end
        end

        session[:room_id] = @room.id
       @messages = @room.messages
        @message = Message.new
  end
  

def create
 @room = Room.new( params[:room] )
  @room.password.blank? ? @room.no_pass = true : @room.no_pass = false
   if @room.save
    flash[:success] = "Добро пожаловать в #{@room.name}"
     redirect_to room_path @room.id
    else
     render 'new'
    end
end

def sendnew

 @date_from = date_from (params[:period])
  @messages = Message.where("room_id = ? AND id > ? AND created_at >= ?",
   params[:id], params[:last_message_id], @date_from)
      
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

def tracking
  @room = Room.find(params[:id])
  @trackingjson = @room.users
  @json = update_tracking(@trackingjson, session[:user_name],params[:active])
  @room.users = @json
  @room.save!


  respond_to do |format|
      format.json { 
        render :json => @json

          }
        
              
  end
end
      


 

end
