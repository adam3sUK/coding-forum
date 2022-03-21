class MessagesController < ApplicationController
  before_action :find_user

  def create
    @user = User.find(params[:user_id])
    @message = @user.inbox.messages.create(message_params.merge(user_id: @current_user.id))
    redirect_to user_path(@user)
  end

  private

  def message_params
    params.require(:message).permit(:title, :body)
  end

  def find_user
    @current_user = User.find_by_id(session[:user_id])
  end
end
