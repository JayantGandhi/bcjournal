class EditorsController < ApplicationController
  before_action :authenticate_editor!

  def manage_posts
    @posts = Post.all.paginate(:page => params[:page]).order('created_at DESC')
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
    @editors = Editor.all
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

  protected

    def editor_params
      params[:editor].permit(
        'email',
        'password',
        'password_confirmation'
      )
    end

end
