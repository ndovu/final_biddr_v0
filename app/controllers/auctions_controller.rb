class AuctionsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @auctions = Auction.all
  end

  def new
    @auction = Auction.new
    
  end

  def create
    @auction = Auction.new auction_params
    @auction.save

  end

  def auction_params 
    params.require(:auction).permit(:title, :description, :reserve_price, :ends_on)
  end

end
