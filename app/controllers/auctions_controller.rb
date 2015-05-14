class AuctionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @auctions = Auction.all
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new auction_params
    @auction.user = current_user
    if @auction.save
      flash[:notice] = "Awesome! Your auction has been created!"
      redirect_to auction_path(@auction)
    else
      flash[:alert] = "Oops! Something went wrong. Auction not created."
      render :new
    end
  end

  def show
    @auction = Auction.find params[:id]
  end

  def edit
    @auction = current_user.auctions.find params[:id]
  end

  def update
    @auction = current_user.auctions.find params[:id]
    if @auction.update auction_params
      redirect_to @auction, notice: "Sweet! The auction has been updated."
    else
      flash[:alert] = "Uh-oh... the auction was not updated."
      render :edit
    end
  end

  def destroy
    @auction = current_user.auctions.find params[:id]
    @auction.destroy
    redirect_to auctions_path, notice: "Ka-boom! Auction destroyed."
  end
  
  private

  def auction_params 
    params.require(:auction).permit(:title, :description, :reserve_price, :ends_on, :current_price)
  end

end
