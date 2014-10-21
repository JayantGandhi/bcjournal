class PostsController < ApplicationController

  def show
    @post = Post.find_by_id(params[:id])
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

end
