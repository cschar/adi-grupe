class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    puts params[:checkedDrag]
    puts 'checked drag'
    if params[:checkedDrag] != nil
      @checkedDrag = params[:checkedDrag]
    else
      @checkedDrag = true
    end

    # @transactions = Transaction.all
    @current_page = params[:page] ||= 1
    puts "current & page #{@current_page} #{params[:page]}"
    @transactions = if params[:l] && params[:page]
                      puts "=Using page and l"
                      # debugger
                      sw_lat, sw_lng, ne_lat, ne_lng = params[:l].split(",")

                      # looking at a map
                      # longtiude across map  -180 -- right --> 180
                      # latitude north south 70 ---- down ---> -70

                      t2 = Transaction.where(
                          "latitude < :ne_lat AND
                           latitude > :sw_lat AND
                           longitude > :sw_lng AND
                           longitude < :ne_lng",
                          {ne_lat: ne_lat, sw_lat: sw_lat, sw_lng: sw_lng, ne_lng: ne_lng})
                      puts "#{t2.count}  geo results"

                      t2.page(@current_page).per(100)


                    else
                      puts "==== normal "
                        Transaction.all.page(@current_page).per(100)
                      end
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:street, :city, :zip, :state, :beds, :baths, :sq__ft, :sale_date, :price, :latitude, :longitude)
    end
end
