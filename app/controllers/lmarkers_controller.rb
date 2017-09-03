class LmarkersController < ApplicationController
  before_action :set_lmarker, only: [:show, :edit, :update, :destroy]

  # GET /lmarkers
  # GET /lmarkers.json
  def index
    @lmarkers = Lmarker.all
  end

  # GET /lmarkers/1
  # GET /lmarkers/1.json
  def show
  end

  # GET /lmarkers/new
  def new
    @lmarker = Lmarker.new
  end

  # GET /lmarkers/1/edit
  def edit
  end

  # POST /lmarkers
  # POST /lmarkers.json
  def create
    @lmarker = Lmarker.new(lmarker_params)

    respond_to do |format|
      if @lmarker.save
        format.html { redirect_to @lmarker, notice: 'Lmarker was successfully created.' }
        format.json { render :show, status: :created, location: @lmarker }
      else
        format.html { render :new }
        format.json { render json: @lmarker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lmarkers/1
  # PATCH/PUT /lmarkers/1.json
  def update
    respond_to do |format|
      if @lmarker.update(lmarker_params)
        format.html { redirect_to @lmarker, notice: 'Lmarker was successfully updated.' }
        format.json { render :show, status: :ok, location: @lmarker }
      else
        format.html { render :edit }
        format.json { render json: @lmarker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lmarkers/1
  # DELETE /lmarkers/1.json
  def destroy
    @lmarker.destroy
    respond_to do |format|
      format.html { redirect_to lmarkers_url, notice: 'Lmarker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lmarker
      @lmarker = Lmarker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lmarker_params
      params.require(:lmarker).permit(:lat, :lng, :user_id, :ltype)
    end
end
