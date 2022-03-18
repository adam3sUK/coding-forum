class PostsController < ApplicationController
  before_action :find_user

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.create(post_params.merge(user_id: @user.id))
    redirect_to topic_path(@topic)
  end

  def edit
    if @user.id == Post.find(params[:id]).user.id
      @post = Post.find(params[:id])
    else
      redirect_to topic_path(Post.find(params[:id]).topic)
    end
  end

  def update
    @post = Post.find(params[:id])
    if @user.id == @post.user.id
      if @post.update(post_params)
        redirect_to topic_path(Post.find(params[:id]).topic)
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to topic_path(Post.find(params[:id]).topic)
    end
  end 

  private
    def post_params
      params.require(:post).permit(:content)
    end

    def find_user
      @user = User.find_by_id(session[:user_id])
    end
end
