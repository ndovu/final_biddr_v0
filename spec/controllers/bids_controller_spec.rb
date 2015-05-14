require 'rails_helper'

RSpec.describe BidsController, type: :controller do

  let(:user)     { create(:user) }
  let(:auction) { create(:auction) }
  let(:bid)   { create(:bid, user: user, auction: auction)   }
  let(:bid_1) { create(:bid, auction: auction) }

  describe "#create" do
    context "user signed in" do
      before { login(user) }

      context "with valid params" do

        def valid_request
          post :create, auction_id: auction.id,
                        bid: attributes_for(:bid)
        end

        it "increases the number of bids in the database" do
          expect { valid_request }.to change { Bid.count }.by(1)
        end

        it "associates the bid with the logged in user" do
          valid_request
          expect(Bid.last.user).to eq(user)
        end

        it "associates the bid with the auctuon whose id is passed" do
          valid_request
          expect(Bid.last.auction).to eq(auction)
        end

        it "redirects to auction show page" do
          valid_request
          expect(response).to redirect_to(auction_path(auction))
        end

        it "sets a flash message" do
          valid_request
          expect(flash[:notice]).to be
        end
      end
      context "with invalid params" do
        def invalid_request
          post :create, auction_id: auction.id,
                        bid: {amount: -1}
        end

        it "doesn't increase the number of bids in the database" do
          expect { invalid_request }.not_to change { Bid.count }
        end

        it "renders the auction show page" do
          invalid_request
          expect(response).to render_template("auctions/show")
        end

        it "sets an alert flash message" do
          invalid_request
          expect(flash[:alert]).to be
        end

      end
    end
    context "user not signed in" do
      it "redirects to the user sign in page" do
        post :create, auction_id: auction.id, 
                      bid: attributes_for(:bid)
        expect(response).to redirect_to new_session_path
      end
    end
  end

  describe "#destroy" do
    context "with user not signed in" do
      it "redirects to the sign in page" do
        delete :destroy, id: bid.id,
                         auction_id: auction.id
        expect(response).to redirect_to new_session_path
      end
    end

    context "with user sign in" do
      before { login(user) }

      context "user is owner" do
        def valid_request
          delete :destroy, id: bid.id,
                           auction_id: auction.id
        end

        it "reduces the bid numbers in DB by 1" do
          bid
          expect { valid_request }.to change { Bid.count }.by(-1)
        end

        it "redirect to auction show page" do
          valid_request
          expect(response).to redirect_to(auction_path(auction))
        end

        it "sets a flash message" do
          valid_request
          expect(flash[:notice]).to be
        end
      end

      context "user is not owner" do
        it "throws an error" do
          expect do
            delete :destroy, id: bid_1.id,
                             auction_id: auction.id
          end.to raise_error
        end
      end
    end
  end
end