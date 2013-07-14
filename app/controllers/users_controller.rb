class UsersController < ApplicationController
 def new
  	 @user = User.new
  end

def index
      @users = User.paginate(page: params[:page])
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


  private
def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
end


  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
