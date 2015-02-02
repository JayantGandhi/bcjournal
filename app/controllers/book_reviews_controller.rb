class PostsController < ApplicationController
  before_action :authenticate_editor!, only: [:new, :edit, :destroy]
  before_action :set_book_review, only: [:show, :edit, :update, :destroy, :publish, :unpublish]

  def show
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


  private
    def book_review_params
      params[:book_review].permit(
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

      )
    end

    def set_book_review
      @book_review = Post.find_by_slug(params[:id])
    end

end