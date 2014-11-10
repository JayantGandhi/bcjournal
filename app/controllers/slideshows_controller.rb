class SlideshowsController < ApplicationController
  def edit
    @slideshow = Slideshow.first

    @posts = Post.where(published: true).order('created_at DESC')
  end

  def update
    @slideshow = Slideshow.first

    if @slideshow.update_attributes!(slideshow_params)
      redirect_to editor_panel_path
    else
    end
  end

  protected
    def slideshow_params
      params[:slideshow].permit(post_ids: [])
    end
end
