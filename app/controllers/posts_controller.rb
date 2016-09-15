class PostsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.new(post_params.merge(user: current_user))
    if @post.save
      respond_to do |format|
        format.js
      end
    else
      render 'new'
    end
  end

  def index
    @posts = Post.published
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      respond_to do |format|
        format.js
      end
    end
  end

  def new
    @post = Post.new
  end

  def publish
    @post = Post.find(params[:post_id])
    return @post.update(post_params) if @post.published
    if @post.valid?(:publish)
      @post.update(post_params)
      SlackNotifierWorker.perform_async(:new_post, post_id: @post.id)
    end
  end

  def add_message
    post_user = Post.find(params[:post_id]).user
    if channel = current_user.private_channel_with(post_user)
      message = Message.create(body: params[:body], channel: channel, user: current_user)
    else
      channel = Channel.create(building: post_user.building, channel_type: "private")
      message = Message.create(body: params[:body], channel: channel, user: current_user)
      current_user.channels << channel
      post_user.channels << channel
    end
    redirect_to appartments_path(current_user.building.slug, channel)
  end


  private

  def post_params
    params.require(:post).permit(
      :description,
      :title,
      :published,
      :availability,
      :price,
      :mobile_phone,
      :show_mobile_phone,
      :user_id,
      :tags => [])
  end

end
