class RoomsController < ApplicationController
 before_filter :signed_in_user
                    
 before_filter :only_owner,
                only: [:edit, :destroy, :update]

def destroy
   @room = Room.find(params[:id])
   @room.destroy
   if @room.save
    flash[:success] = "Комната удалена"
    redirect_to rooms_path
   else
    flash[:error] = "Неудача"
    render 'edit'
    end

end

  
def edit

  @room = Room.find(params[:id])
end

def update

if params[:chpass] #was password changed?
  @room.remember_token = create_remember_token
  params[:room][:password].blank? ? @room.no_pass = true : @room.no_pass = false
end

  if @room.update_attributes(params[:room])
    flash[:success] = "Обновлено!"
   redirect_to room_path
  else
    render 'edit'
  end
end  


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
    store_location
    @room = Room.find(params[:id])
    @attachfile = @room.attach_file.build

        
          if !check_room_token(@room.id) then
            redirect_to password_request_room_path(@room)
           end
        

        session[:room_id] = @room.id
       @messages = @room.messages
        @message = Message.new
  end
  

def create
 @room = current_user.rooms.build( params[:room] )
 @room.remember_token = create_remember_token
  @room.password.blank? ? @room.no_pass = true : @room.no_pass = false
   if @room.save
    flash[:success] = "Добро пожаловать в #{@room.name}"
     redirect_to room_path @room.id
    else
     render 'new'
    end
end

def sendnew

 @date_from = date_from(params[:period])
 
 if !check_room_token(params[:room_id].to_i) then 
  render :json=> "Доступ запрещен"
  return
 end 

  @messages = Message.where("room_id = ? AND id > ? AND created_at >= ?",
   params[:room_id], params[:last_message_id], @date_from)
      
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
