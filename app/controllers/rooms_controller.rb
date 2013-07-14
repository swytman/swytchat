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
flash[:success] = "p:#{@room.password} c:#{@room.password_confirmation} #{@room.no_pass} #{@room.password_digest}"

 if @room.save
    flash[:success] = "Добро пожаловать в #{@room.name}"
     redirect_to room_path @room.id
    else
     render 'new'
    end
end

 

end
