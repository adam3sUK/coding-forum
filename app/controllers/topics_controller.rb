class TopicsController < ApplicationController
  before_action :find_user

  def index
    @topics = Topic.all.order(updated_at: :desc)
    @topics = Kaminari.paginate_array(@topics).page(params[:page]).per(10)
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts.order(created_at: :desc).reverse
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(10)
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
    if @user.id == Topic.find(params[:id]).user.id
      @topic = Topic.find(params[:id])
    else
      redirect_to topic_path(Topic.find(params[:id]))
    end
  end

  def update
    @topic = Topic.find(params[:id])
    if @user.id == @topic.user.id
      if @topic.update(topic_params)
        redirect_to @topic
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to topic_path(@topic)
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
  