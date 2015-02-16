class SitemapController < ApplicationController
  def index
    @static_pages = ['http://www.saisjournal.org', 'http://www.saisjournal.org/about', 'http://www.saisjournal.org/contact', 'http://www.saisjournal.org/submissions']
    @posts = Post.all
    @issues = Issue.all
    respond_to do |format|
      format.xml
    end
  end
end
