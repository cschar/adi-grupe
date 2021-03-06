class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  # GET /locations
  # GET /locations.json
  def index

    # Location sort by Region sorting strategy 1
    # rely on Google Geocode
    # if params[:near] == nil || params[:near].strip == ""
    #   params[:near] = current_user.start_location
    # end
    
    if params[:checkedDrag] != nil
      @checkedDrag = params[:checkedDrag]
    else
      @checkedDrag = true
    end

    @current_page = params[:page] ||= 1
    #puts "current & page #{@current_page} #{params[:page]}"


    @locations =
    
      if params[:l] && params[:page]
        puts "=Using page and l"
        # debugger
        sw_lat, sw_lng, ne_lat, ne_lng = params[:l].split(",")

        Location.search("*",
            page: params[:page], per_page: 5,
            where: {
              location: {
                  top_left: {
                      lat: ne_lat,
                      lon: sw_lng
                  },
                  bottom_right: {
                      lat: sw_lat,
                      lon: ne_lng
                  }
              }
        })


      elsif params[:near] && params[:near].strip != ""  # search box


        location = Geocoder.search(params[:near]).first

        Location.search "*",
                        page: params[:page], per_page: 5,
                        boost_by_distance: {location:
                         {origin: {lat: location.latitude,
                                   lon: location.longitude}}},
                        where: {
                            location: {
                                near: {
                                    lat: location.latitude,
                                    lon: location.longitude
                                },
                                within: "10km"
                            }
                        }

      else

      # Location sort by Region sorting strategy 2
      # rely on hardcoded region on location model
        Location.where(region: current_user.start_location).page(@current_page).order("updated_at DESC").per(5)
      #  Location.all.page(@current_page).order("created_at ASC").per(5)
      #  Location.all.page(@current_page).order("updated_at DESC").per(5)
      end

  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @grupes = @location.grupes.all

  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit

  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:name, :latitude, :longitude, :ltype)
    end
end
