class GrupesController < ApplicationController
  before_action :set_grupe, only: [:show, :edit, :update, :destroy, :join, :leave, :confirm, :add_quest]
  before_action :authenticate_user! #, only: [:join]

  @@locked_count = 2

  # GET /grupes
  # GET /grupes.json
  def index
    # @grupes = Grupe.all

    #Grupe.joins(:gups).where('gups.user_id = ?', u.id).group('grupes.id')
    
    
    #@locked_grupes = Grupe.joins(:users).group('grupes.id').having('COUNT(users.id) >= ?', @@locked_count)
    @locked_grupes = Grupe.includes(:gups).where('gups.user_id = ?', current_user.id).where.not('gups.confirmed_time' => nil)
    
    @my_grupes = current_user.grupes - @locked_grupes
  end

  # GET /grupes/1
  # GET /grupes/1.json
  def show

    @quests = @grupe.quests.all
    
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

    #@grupe.users << current_user ## equivalent of #Gup.create user: current_user, grupe: @grupe
    Gup.create user: current_user, grupe: @grupe, is_creator: true

    @grupe.creator_id = current_user.id
    

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


  def join
    grupe_users = @grupe.users

    respond_to do |format|
      # debugger
      if grupe_users.count < 5 and not grupe_users.exists?(current_user.id)
        
        Gup.create user: current_user, grupe: @grupe

        format.html { redirect_to @grupe, notice: 'Joined grupe' }
        format.json { render :show, status: :ok, location: @grupe }
      else
        format.html { redirect_to location_path(@grupe.location),  alert: 'Cant join that grupe' }
        format.json { render json: @grupe.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm 
    
    # grupe_users = @grupe.users

    respond_to do |format|
      # if @grupe.users.count == 5
      if @grupe.users.count >= 2
      
        gup = current_user.gups.where(grupe: @grupe).first
        gup.confirmed_time = DateTime.now
        gup.save

        @grupe.locked_in_at = DateTime.now
        @grupe.save
        
        format.html { redirect_to @grupe, notice: 'Confirmed meeting with grupe!' }
        format.json { render :show, status: :ok, location: @grupe }
      else
        format.html { redirect_to @grupe,  alert: 'Cant confirm without 5 ppl' }
        format.json { render json: @grupe.errors, status: :unprocessable_entity }
      end
    end
  end

  def leave
    location = @grupe.location
    respond_to do |format|

      if @grupe.users.exists?(current_user.id)

        if @grupe.creator_id == current_user.id
          Gup.where(grupe: @grupe).destroy_all
          @grupe.destroy
        else
          Gup.where(grupe: @grupe, user: current_user).first.destroy
        end


        format.html { redirect_to location_path(location), notice: 'Left grupe ' + @grupe.name }
        format.json { render :show, status: :ok, location: locations_path }
      else
        format.html { redirect_to location_path(location),  alert: 'Cant leave that grupe' }
        format.json { render json: @grupe.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_quest

    @quests = Quest.page(params[:page]).per(5)
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
