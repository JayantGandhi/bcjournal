class EditorsController < Devise::RegistrationsController
  before_action :authenticate_editor!

  def manage_posts
    @posts = Post.all
  end

  def panel

  end

  def new
    @editor = Editor.new
  end

  def create
    Editor.create!({:email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation] })
  end

end
