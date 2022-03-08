class SessionsController < ActionController::Base

  def create
    @user = User.find_by(username: params[:username])

    if !!@user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      message = "Login failed! Please make sure username and password are correct."
      redirect_to login_path, notice: message
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
