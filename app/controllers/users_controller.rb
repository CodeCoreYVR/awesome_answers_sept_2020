class UsersController < ApplicationController
    def new
        @user=User.new
    end
    def create
    @user=User.new user_params # Strong parameters
    if @user.save
        session[:user_id]=@user.id
        # your application has a session for each user in which you can store small amount of data that will be persisted between https requests. The session is only available in controller and view
        redirect_to root_path, notice: "Logged in"
    else
        render :new
    end
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
