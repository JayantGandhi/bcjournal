class PostsController < ApplicationController
  before_action :authenticate_editor!, only: [:new, :edit, :destroy]

  def show
    @post = Post.find_by_slug(params[:id])
  end

  def index
    @posts = Post.where(:published => true).paginate(:page => params[:page]).order('created_at DESC')
    @missing_images = 0
    @slideshow = Slideshow.first()
    @slides = @slideshow.posts

    for slide in @slides do
      @posts - [slide]
    end
  end

  def new
    @post = Post.new

    @verticals = Verticals::VERTICALS

    puts @verticals
  end

  def create
    @post = Post.new(post_params)

    @post.slug = @post.title.downcase.gsub(" ", "-").gsub(/\?|\&|\=|\$|\@|\#/, '')

    respond_to do |format|
      if @post.create(post_params)
        format.html { redirect_to @post, notice: 'post was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @post = Post.find_by_slug(params[:id])
  end

  def update
    @post = Post.find_by_slug(params[:id])

    @post.slug = @post.title.downcase.gsub(" ", "-").gsub(/\?|\&|\=|\$|\@|\#/, '')


    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def publish
    @post = Post.find_by_slug(params[:id])

    if !@post.published
      @post.published = true

      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: 'post was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { redirect_to manage_posts_path, notice: 'something went wrong' }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:alert] = 'Looks like it is already published...'
    end
  end

  def unpublish
    @post = Post.find_by_slug(params[:id])

    if @post.published
      @post.published = false

      if @post.save!
        redirect_to manage_posts_path
      end
    else

    end
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
        :tag_list,
        :subtitle,
        :published,
        :book_review,
        :publish_date,
        :archived,
        :author_bio,
        vertical_ids: [],
        sections_attributes: [
          :id,
          :header,
          :body,
          :_destroy
        ],

      )
    end

end
