class EditorsController < ApplicationController
  before_action :authenticate_editor!

  def manage_posts
    @posts = Post.all
  end

  def panel

  end

end
