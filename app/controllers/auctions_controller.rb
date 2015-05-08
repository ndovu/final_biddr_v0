class AuctionsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @auctions = Auction.all
  end

  def new
    @auction = Auction.new
    
  end

  def create
  end
end
