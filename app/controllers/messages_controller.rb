class MessagesController < ApplicationController
  before_action :find_user

  def show
    find_message_owner();
    @user = User.find(params[:user_id])
    if (@current_user == @user) && (@current_user == @message_owner)
    @message = Message.find(params[:id])
    else
      redirect_to user_path(@current_user)
    end
  end

  def create
    @user = User.find(params[:user_id])
    @message = @user.inbox.messages.create(message_params.merge(user_id: @current_user.id))
    redirect_to user_path(@current_user)
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to user_path(@user)
  end

  private

  def message_params
    params.require(:message).permit(:title, :body)
  end

  def find_message_owner
    @message_owner = Message.find(params[:id]).inbox.user
  end

  def find_user
    @current_user = User.find_by_id(session[:user_id])
  end
end
