class PostsController < ApplicationController
  before_action :find_user

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.create(post_params.merge(user_id: @user.id))
    redirect_to topic_path(@topic)
  end

  private
    def post_params
      params.require(:post).permit(:body)
    end

    def find_user
      @user = User.find_by_id(session[:user_id])
    end
end
