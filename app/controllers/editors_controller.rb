class EditorsController < ApplicationController
  before_action :authenticate_editor!
  helper_method :sort_column, :sort_direction

  def manage_posts
    @posts = Post.not_book_review.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])
  end

  def manage_book_reviews
    @book_reviews = Post.book_review.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])
  end

  def manage_issues
    @issues = Issue.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])
  end

  def panel

  end

  def show

  end

  def new
    @editor = Editor.new
  end

  def create
    @editor = Editor.new(editor_params)

    if @editor.save!
      flash[:message] = "Success!"
      redirect_to editor_panel_path
    else
      flash[:error] = 'Whoops! Something Happened'
    end
  end

  def index
    @editors = Editor.where.not(email: 'jgandhi2@jhu.edu')
  end

  def destroy
    @editor = Editor.find_by_id(params[:id])

    if @editor.nil?
      redirect_to editors_path
    elsif @editor.email == 'jgandhi2@jhu.edu'
      flash[:message] = 'Ahahah, you didn\'t say the magic word!'
      redirect_to editor_panel_path
    elsif @editor.destroy!
      redirect_to editor_panel_path
    end
  end

  private

    def editor_params
      params[:editor].permit(
        'email',
        'password',
        'password_confirmation'
      )
    end

    def sort_column
      Post.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end

end
