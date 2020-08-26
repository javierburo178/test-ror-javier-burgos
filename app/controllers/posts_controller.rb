class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      if params[:post][:image].present?
        render :crop
      else
        flash[:notice] = "Post #{@post.title} created successfully"
        redirect_to posts_path
      end
    else
      flash[:alert] = @post.errors.full_messages.to_sentence
      render :new
    end
  end


  def edit
    @post = Post.find(params[:id])
  end


  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      if params[:post][:image].present?
        render :crop
      else
        flash[:notice] = "Post #{@post.title} created successfully"
        redirect_to @post
      end
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url, notice: "Successfully destroyed post."
  end

  private

  def post_params
    params.require(:post).permit(:title,
                                 :description,
                                 :category,
                                 :image,
                                 :crop_x,
                                 :crop_y,
                                 :crop_h,
                                 :crop_w)
  end
end
