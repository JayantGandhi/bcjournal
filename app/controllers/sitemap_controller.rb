class SitemapController < ApplicationController
  def index
    @static_pages = ['/', '/about', '/contact', '/submissions']
    @posts = Post.all
    @issues = Issue.all
    respond_to do |format|
      format.xml
    end
  end
end
