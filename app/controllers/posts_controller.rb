class PostsController < ApplicationController
  before_action :authenticate_editor!, only: [:new, :edit, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :publish, :unpublish]

  def show
    @no_nav = true
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
    @post.slug = @post.title.downcase.gsub(" ", "-").gsub(/\?|\&|\=|\$|\@|\#|\,|\.|\%/, '')

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
    @post = Post.find_by_slug(params[:id])
  end

  def update
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
        vertical_ids: [],
        sections_attributes: [
          :id,
          :header,
          :body,
          :position,
          :_destroy
        ],

      )
    end

    def set_post
      @post = Post.find_by_slug(params[:id])
    end

end
