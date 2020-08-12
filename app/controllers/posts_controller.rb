class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @posts = Post.all.upload_attachments
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "Post #{@post.title} created successfully"
      redirect_to posts_path
    else
      flash[:alert] = @post.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title,
                                 :description,
                                 :category,
                                 :image)
  end
end
