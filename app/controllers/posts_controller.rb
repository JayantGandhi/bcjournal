class PostsController < ApplicationController
  before_action :authenticate_editor!, only: [:new, :edit, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :publish, :unpublish]
  before_action :set_slideshow, only: [:index, :vertical_sort]

  def show
    if @post.book_review
      redirect_to book_review_path(@post)
    end

    # shorten the url with bitly
    @bitly_url = Bitly.client.shorten(request.original_url).short_url

    # construct hashtags
    @hashtags = ''
    for tag in @post.tags
      @hashtags +=" ##{tag.name.gsub(/\s+/, "")}"
    end

    # Set the page title
    @page_title = @post.title
    @page_description = @post.blurb.slice(0..154)
  end

  def index
    @position = 0
    @missing_images = 0
    @every_other = false

    if params[:search]
      @posts = Post.published.search(params[:search]).paginate(:page => params[:page], per_page: 23).order('publish_date DESC')
    else
      @posts = Post.published.paginate(:page => params[:page], per_page: 23).order('publish_date DESC')
    end
  end

  def new
    @post = Post.new

    @verticals = Verticals::VERTICALS

    puts @verticals
  end

  def create
    @post = Post.new(post_params)
    @post.slug = @post.title.downcase.gsub(" ", "-").gsub(/\?|\&|\=|\$|\@|\#|\,|\.|\%|\;|\:/, '')

    check_photo_url

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'post was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    if @post.book_review
      redirect_to edit_book_review_path(@post)
    end

    @post = Post.find_by_slug(params[:id])
  end

  def update
    @post.slug = @post.title.downcase.gsub(" ", "-").gsub(/\?|\&|\=|\$|\@|\#|\,|\;|\:/, '')

    check_photo_url
    puts post_params[:photo_url]

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

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to manage_posts_path }
      format.json { head :no_content }
    end
  end

  def publish
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
    if @post.published
      @post.published = false

      if @post.save!
        redirect_to manage_posts_path
      end
    else

    end
  end

  def vertical_sort
    @position = 0
    @missing_images = 0
    @every_other = false

    search = params[:search]

    @current_vertical = Vertical.find_by_slug(search)

    @posts = Post.published.
              includes(:verticals).
              where('verticals.id' => @current_vertical.id).
              paginate(:page => params[:page], per_page: 18).
              order('publish_date DESC')

    # TODO: Make this just add verticals to the search params...

    respond_to do |format|
      format.html {render 'index'}
      format.js
    end
  end

  private

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
        :photo_credit,
        :photo_url,
        :photo_title,
        :abstract,
        :notes,
        vertical_ids: [],
        sections_attributes: [
          :id,
          :header,
          :body,
          :position,
          :_destroy
        ],
        post_ids: [],
      )
    end

    def set_post
      @post = Post.find_by_slug(params[:id])
    end

    def check_photo_url
      if post_params[:photo_url].start_with?("http://", "https://")
        # do nothing
      else
        post_params[:photo_url].prepend("http://")
        puts post_params[:photo_url]
      end
    end

    def set_slideshow
      @slideshow = Slideshow.first()
      @slides = @slideshow.posts
    end

end
