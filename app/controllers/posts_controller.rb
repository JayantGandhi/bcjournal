class PostsController < ApplicationController
  before_action :authenticate_editor!, only: [:new, :edit, :destroy]

  def show
    @post = Post.find_by_slug(params[:id])
  end

  def index
    @posts = Post.where(:published => true).paginate(:page => params[:page]).order('created_at DESC')

    @slideshow = @posts[0..4]
  end

  def new
    @post = Post.new

    @verticals = Verticals::VERTICALS

    puts @verticals
  end

  def create
    @post = Post.new(post_params)

    @post.slug = @post.title.downcase.gsub(" ", "-").gsub(/\?|\&|\=|\$|\@|\#/, '')

    if @post.save!
      flash[:message] = "Huzzah!"
      redirect_to @post
    else
      flash[:error] = 'umm...'
    end
  end

  def edit
    @post = Post.find_by_slug(params[:id])
  end

  def update
    @post = Post.find_by_slug(params[:id])

    @post.slug = @post.title.downcase.gsub(" ", "-").gsub(/\?|\&|\=|\$|\@|\#/, '')


    if @post.update_attributes!(post_params)
      flash[:message] = "Huzzah!"
      redirect_to @post
    else
      flash[:error] = 'umm...'
    end
  end

  def publish
    @post = Post.find_by_slug(params[:id])

    if !@post.published
      @post.published = true

      if @post.save!
        redirect_to @post
      else
        flash[:alert] = "Something went wrong and your post didn't get published!"
      end
    else
      flash[:alert] = 'Looks like it is already published...'
    end
  end

  def unpublish
    @post = Post.find_by_slug(params[:id])
  end

  protected

    def post_params
      params[:post].permit(
        :title,
        :by_line,
        :subtitle,
        :cover_image,
        :blurb,
        :vertical_id,
        sections_attributes: [
          :id,
          :header,
          :body,
          :_destroy
        ],

      )
    end

end
