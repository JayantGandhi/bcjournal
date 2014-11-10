class SlideshowsController < ApplicationController
  def edit
    @slideshow = Slideshow.first
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
      params[:slideshow].permit(posts_attributes: [:id, :slideshow_id])
    end
end
