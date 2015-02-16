class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]
  before_action :get_posts, only: [:new, :edit]

  def index
    @issues = Issue.all.paginate(:page => params[:page], per_page: 10).order(:year)
  end

  def show

  end

  def new
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
    @issue.slug = "issue-#{@issue.year.strftime('%Y')}"

    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue, notice: 'issue was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to manage_issues_path }
      format.json { head :no_content }
    end
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
        post_ids: []
      )
    end

    def set_issue
      @issue = Issue.find_by_slug(params[:id])
    end

    def get_posts
      @posts = Post.where(published: true).order('created_at DESC')
    end

end
