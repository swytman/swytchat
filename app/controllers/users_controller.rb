class UsersController < ApplicationController
 
before_filter :signed_in_user,
                only: [:index, :show, :edit] 
def new
 @user = User.new
end

def show

  @user = User.find(params[:id])
  @user_registred = @user.created_at.to_formatted_s(:long) 
  @cnt_messages = Message.where("user_id = ?", params[:id]).count
  
  store_location
end


def index
  @users = User.paginate(page: params[:page])
  
end

def edit

  @user = User.find(params[:id])
  if current_user.id!=@user.id
     flash[:error] = "Вы не можете редактировать этого пользователя"
     return redirect_back_or root_path
  end


end


def create
	@user = User.create( user_params )
  
  
	 if @user.save
      flash[:success] = "Добро пожаловать, #{@user.name}"
      sign_in @user
      redirect_to root_path
    else
      render 'new'
    end
end

def update

  @user = User.find_by_id(params[:id])
    if @user.nil? #only author can edit a room
     flash[:error] = "Пользователь не найден"
     return redirect_to root_path
    end

    if @user.id!=current_user.id #only author can edit a room
     flash[:error] = "Вы не можете редактировать этого пользователя"
     return redirect_to root_path
    end


  if params[:chpass]==nil #need change password?
    params[:user].delete :password
    params[:user].delete :password_confirmation
  end

    @user.change_password = params[:chpass] #skip validation flag

    @user.avatar = params[:user][:avatar]

  if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to users_path
    else
      render 'edit'
    end
end  

private

def correct_user
  @user = User.find(params[:id])
  redirect_to(root_path) unless current_user?(@user)
end




 def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end
end
