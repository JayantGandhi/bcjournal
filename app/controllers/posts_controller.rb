class PostsController < ApplicationController

  def show
    @post = Post.find_by_id(params[:id])
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create

  end

  def edit

  end

  def update

  end

  def publish
    @post = Post.find_by_id(params[:id])

    if !@post.published
      @post.published = true

      if @post.save!
        redirect_to @post
      else
        flash[:alert] = "Something went wrong and your post didn't get published!"
      end
    else
      flash[:alert] = 'Looks like it is already published...'
    end
  end

  def unpublish
    @post = Post.find_by_id(params[:id])
  end

  protected

    def post_params
      params[:post].permit(
        'title',
        'by_line',
        'subtitle',
        'cover_image'
      )
    end

end
