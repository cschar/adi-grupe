class FiretreesController < ApplicationController
  before_action :set_firetree, only: [:show, :edit, :update, :destroy]

  # GET /firetrees
  # GET /firetrees.json
  def index
    @firetrees = Firetree.all
  end

  # GET /firetrees/1
  # GET /firetrees/1.json
  def show
  end

  # GET /firetrees/new
  def new
    @firetree = Firetree.new
  end

  # GET /firetrees/1/edit
  def edit
  end

  # POST /firetrees
  # POST /firetrees.json
  def create
    @firetree = Firetree.new(firetree_params)

    respond_to do |format|
      if @firetree.save
        format.html { redirect_to @firetree, notice: 'Firetree was successfully created.' }
        format.json { render :show, status: :created, location: @firetree }
      else
        format.html { render :new }
        format.json { render json: @firetree.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /firetrees/1
  # PATCH/PUT /firetrees/1.json
  def update
    respond_to do |format|
      if @firetree.update(firetree_params)
        format.html { redirect_to @firetree, notice: 'Firetree was successfully updated.' }
        format.json { render :show, status: :ok, location: @firetree }
      else
        format.html { render :edit }
        format.json { render json: @firetree.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /firetrees/1
  # DELETE /firetrees/1.json
  def destroy
    @firetree.destroy
    respond_to do |format|
      format.html { redirect_to firetrees_url, notice: 'Firetree was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_firetree
      @firetree = Firetree.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def firetree_params
      params.require(:firetree).permit(:name, :body, :user_id)
    end
end
