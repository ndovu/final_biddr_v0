class AuctionsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @auctions = Auction.all
  end

  def new

  end
end
