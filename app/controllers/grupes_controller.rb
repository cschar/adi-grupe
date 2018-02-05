class GrupesController < ApplicationController
  before_action :set_grupe, only: [:show, :edit, :update, :destroy, :join]
  before_action :authenticate_user! #, only: [:join]

  # GET /grupes
  # GET /grupes.json
  def index
    # @grupes = Grupe.all

    ## save ids on user for quick access?
    @my_grupes = Grupe.joins(:users).where('users.id = ?', current_user.id).group('grupes.id')
    @locked_grupes = Grupe.joins(:users).where('users.id = 5').group('grupes.id').having('COUNT(grupes_users.user_id) = 5')
  end

  # GET /grupes/1
  # GET /grupes/1.json
  def show
  end

  # GET /grupes/new
  def new
    @GET_location_id = params[:location_id]
    @grupe = Grupe.new
  end

  # GET /grupes/1/edit
  def edit
  end

  # POST /grupes
  # POST /grupes.json
  def create
    @grupe = Grupe.new(grupe_params)

    @grupe.users << current_user
    respond_to do |format|
      if @grupe.save
        format.html { redirect_to @grupe, notice: 'Grupe was successfully created11.' }
        format.json { render :show, status: :created, location: @grupe }
      else
        format.html { render :new }
        format.json { render json: @grupe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grupes/1
  # PATCH/PUT /grupes/1.json
  def update
    respond_to do |format|
      if @grupe.update(grupe_params)
        format.html { redirect_to @grupe, notice: 'Grupe was successfully updated.' }
        format.json { render :show, status: :ok, location: @grupe }
      else
        format.html { render :edit }
        format.json { render json: @grupe.errors, status: :unprocessable_entity }
      end
    end
  end

  def join
    grupe_users = @grupe.users

    respond_to do |format|
      # debugger
      if grupe_users.count < 5
        @grupe.users << current_user

        format.html { redirect_to @grupe, notice: 'Joined grupe' }
        format.json { render :show, status: :ok, location: @grupe }
      else
        format.html { redirect_to location_path(@grupe.location),  alert: 'Grupe is already full! start another one' }
        format.json { render json: @grupe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grupes/1
  # DELETE /grupes/1.json
  def destroy
    @grupe.destroy
    respond_to do |format|
      format.html { redirect_to grupes_url, notice: 'Grupe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grupe
      @grupe = Grupe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grupe_params
      params.require(:grupe).permit(:name, :location_id)
    end
end
