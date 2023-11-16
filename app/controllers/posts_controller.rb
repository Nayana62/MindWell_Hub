class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy

    redirect_to posts_path, notice: 'Post was successfully deleted.'
  end

  def like
    @post = Post.find(params[:id])
    current_user.likes.create(post: @post)
    redirect_to posts_path , notice: 'Liked the post!'
  end

  def unlike
    @post = Post.find(params[:id])
    current_user.likes.find_by(post: @post).destroy
    redirect_to posts_path, notice: 'Unliked the post!'
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
