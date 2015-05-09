class BidsController < ApplicationController
  before_action :authenticate_user!

  def create
    @auction        = Auction.find params[:auction_id]
    @bid            = Bid.new bid_params
    @bid.user       = current_user
    @bid.auction    = @auction
    if @bid.save
      @auction.update_attributes(current_price: @bid.amount)
      redirect_to @auction, notice: "Bid created"
    else
      flash[:alert] = "Bid not created"
      render "auctions/show"
    end
  end

  def destroy
    @auction = Auction.find params[:auction_id]
    @bid   = current_user.bids.find params[:id]
    @bid.destroy
    redirect_to @auction, notice: "Bid destroyed"
  end

  private

  def bid_params
    params.require(:bid).permit(:amount)
  end
end