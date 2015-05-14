class WelcomeController < ApplicationController
  def index
    @auctions = Auction.most_recent(5)
  end
end