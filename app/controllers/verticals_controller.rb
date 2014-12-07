class VerticalsController < ApplicationController
  before_action :authenticate_editor!
  before_action :set_vertical, only: [:show, :edit, :update, :destroy]

  # GET /verticals
  # GET /verticals.json
  def index
    @verticals = Vertical.all
  end

  # GET /verticals/1
  # GET /verticals/1.json
  def show
  end

  # GET /verticals/new
  def new
    @vertical = Vertical.new
  end

  # GET /verticals/1/edit
  def edit
  end

  # POST /verticals
  # POST /verticals.json
  def create
    @vertical = Vertical.new(vertical_params)

    respond_to do |format|
      if @vertical.save
        format.html { redirect_to @vertical, notice: 'vertical was successfully created.' }
        format.js
      else
        format.html { render action: 'new' }
        format.js
      end
    end
  end

  # PATCH/PUT /verticals/1
  # PATCH/PUT /verticals/1.json
  def update
    respond_to do |format|
      if @vertical.update(vertical_params)
        format.html { redirect_to @vertical, notice: 'vertical was successfully updated.' }
        format.js
      else
        format.html { render action: 'edit' }
        format.js
      end
    end
  end

  # DELETE /verticals/1
  # DELETE /verticals/1.json
  def destroy
    @vertical = Vertical.destroy(params[:id])
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vertical
      @vertical = Vertical.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vertical_params
      params.require(:vertical).permit(:name)
    end
end

