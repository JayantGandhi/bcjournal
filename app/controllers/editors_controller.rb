class EditorsController < ApplicationController
  before_action :authenticate_editor!

  def manage_posts
    @posts = Post.all
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

  protected

    def editor_params
      params[:editor].permit(
        'email',
        'password',
        'password_confirmation'
      )
    end

end
