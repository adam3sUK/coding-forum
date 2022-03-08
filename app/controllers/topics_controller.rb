class TopicsController < ApplicationController
  before_action :find_user

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
    @topic.increment!(:view)
  end

  def new
    if @user
      @topic = Topic.new
    else
      redirect_to root_path
    end
  end

  def create
    if @user
      @topic = Topic.create(topic_params.merge(user_id: @user.id))
      if @topic.save
        @topic.posts.create(post_params.merge(user_id: @user.id))
        redirect_to @topic
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])

    if @topic.update(topic_params)
      redirect_to @topic
    else
      render :edit, status: :unprocessable_entity
    end
  end 

  private
    def topic_params
      params.require(:topic).permit(:title)
    end

    def post_params
      params.require(:topic).permit(:body)
    end

    def find_user
      @user = User.find_by_id(session[:user_id])
    end
end
  