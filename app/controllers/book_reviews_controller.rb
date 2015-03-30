class BookReviewsController < ApplicationController
  before_action :authenticate_editor!, only: [:new, :edit, :destroy]
  before_action :set_book_review, only: [:show, :edit, :update, :destroy, :publish, :unpublish]

  def index
    @book_reviews = Post.published.book_review.paginate(:page => params[:page], per_page: 23).order('publish_date DESC')
    @position = 0
    @missing_images = 0
    @every_other = false
    @slides = nil
  end

  def show
    # shorten the url with bitly
    @bitly_url = Bitly.client.shorten(request.original_url).short_url

    # construct hashtags
    @hashtags = ''
    for tag in @book_review.tags
      @hashtags +=" ##{tag.name.gsub(/\s+/, "")}"
    end

    # Set the page title
    @page_title = @book_review.title
    @page_description = @book_review.blurb.slice(0..154)
  end

  def new
    @book_review = Post.new

    @verticals = Verticals::VERTICALS
  end

  def create
    @book_review = Post.new(book_review_params)
    @book_review.slug = @book_review.title.downcase.gsub(" ", "-").gsub(/\?|\&|\=|\$|\@|\#|\,|\.|\%|\;|\:/, '')

    check_book_url

    respond_to do |format|
      if @book_review.save
        format.html { redirect_to book_review_path(@book_review), notice: 'post was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @book_review.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @book_review = Post.find_by_slug(params[:id])
  end

  def update
    @book_review.slug = @book_review.title.downcase.gsub(" ", "-").gsub(/\?|\&|\=|\$|\@|\#|\,|\;|\:/, '')

    check_book_url

    respond_to do |format|
      if @book_review.update(book_review_params)
        format.html { redirect_to book_review_path(@book_review), notice: 'post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @book_review.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book_review.destroy
    respond_to do |format|
      format.html { redirect_to manage_book_reviews_path }
      format.json { head :no_content }
    end
  end

  def publish
    if !@book_review.published
      @book_review.published = true

      respond_to do |format|
        if @book_review.save
          format.html { redirect_to book_review_path(@book_review), notice: 'post was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { redirect_to manage_book_reviews_path, notice: 'something went wrong' }
          format.json { render json: @book_review.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:alert] = 'Looks like it is already published...'
    end
  end

  def unpublish
    if @book_review.published
      @book_review.published = false

      if @book_review.save!
        redirect_to manage_book_reviews_path
      end
    else

    end
  end


  private
    def book_review_params
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
        :photo_credit,
        :photo_url,
        :photo_title,
        :abstract,
        :notes,
        :author,
        :book_publish_date,
        :publisher,
        :link_to_book,
        :price,
        :author_bio
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

    def check_book_url
      if book_review_params[:link_to_book].start_with?("http://", "https://")
        # do nothing
      else
        book_review_params[:link_to_book].prepend("http://")
      end
    end
end