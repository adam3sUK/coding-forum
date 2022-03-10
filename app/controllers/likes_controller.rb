class LikesController < ApplicationController
  before_action :find_post, :find_user

  def create
    if already_liked?
      flash[:notice] = "You can't like a post more than once."
    else
      @post.likes.create(user_id: @user.id)
    end
    redirect_to topic_path(@post.topic)
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_user
    @user = User.find_by_id(session[:user_id])
  end

  def already_liked?
    Like.where(user_id: @user.id, post_id:
    params[:post_id]).exists?
  end
end
