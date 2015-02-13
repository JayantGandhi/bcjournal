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
    @issue = Issue.new(issue_params)
    @issue.slug = "issue-#{@issue.year.strftime('%Y')}"

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'issue was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
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
