class CardsController < ApplicationController
  before_action :set_card, except: %i[index new create]

  # GET /cards
  def index
    @cards = Card.all
  end

  # GET /cards/1
  def show
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards
  def create
    @card = Card.new(card_params)

    if @card.save
      redirect_to @card, notice: 'Card was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /cards/1
  def update
    if @card.update(card_params)
      redirect_to @card, notice: 'Card was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /cards/1
  def destroy
    @card.destroy
    redirect_to cards_url, notice: 'Card was successfully destroyed.'
  end

  # finds a listing on ebay
  def find_on_ebay
    search_string = URI.escape("#{@card.manufacturer} #{@card.year} #{@card.player_full_name} #{@card.series_number}")
    uri = URI.parse("https://api.ebay.com/buy/browse/v1/item_summary/search?category_ids=213&q=#{search_string}&limit=25")
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{current_user.access_token}"
    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    
    @cards = eval(response.body)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def card_params
      params.require(:card).permit(:user_id, :manufacturer, :year, :player_first_name, :player_last_name, :series_number, :image)
    end
end
