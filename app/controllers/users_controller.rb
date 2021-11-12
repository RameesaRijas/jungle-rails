class UsersController < ApplicationController
  def new
    @user ||= User.new
  end

  def create
    @user = User.new(user_params)

    if User.find_by(email: @user.email)
      redirect_to signup_path
    else
      if @user.save
        session[:user_id] = @user.id
        redirect_to root_path, notice: 'Sign up successful!'
      else
        render :new  
      end
    end

  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
  
end
