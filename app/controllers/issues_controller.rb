class IssuesController < ApplicationController

  def index
    @issues = Issue.all.order(:year)
  end

  def show
    @issue = Issue.find_by_slug(params[:issue])
  end

  def new
    @posts = Post.where(published: true).order('created_at DESC')
    @issue = Issue.new
  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
    def issue_params
      params[:issue].permit(
        :title,
        :year,
        :editorial_team,
        :credits,
        :featured,
        :cover_image,
        posts_attributes: [
          :id,
        ]
      )
    end

end
