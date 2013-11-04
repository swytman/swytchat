class AttachFilesController < ApplicationController

def create
  @attfile = AttachFile.create(params[:files], room_id: params[:room_id], user_id:  params[:user_id] )
  @attfile.room_id = params[:room_id]
  @attfile.user_id = params[:user_id] # how create this in one line???
  if @attfile.save
  	flash[:success] = "Файл #{request.protocol}#{request.host_with_port}#{@attfile.file.url(:original, false)} загружен "
    create_custom_message("Загружен файл #{request.protocol}#{request.host_with_port}#{@attfile.file.url(:original, false)}",
    	@attfile.user_id, @attfile.room_id)
    	
  else
  	flash[:success] = "Файл не загружен"
  end
  redirect_to room_path params[:room_id]

end

end
