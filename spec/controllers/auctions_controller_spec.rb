require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do
  let(:auction_1) { create(:auction) }
  let(:auction_2) { create(:auction) }
  let(:user)     { create(:user) }

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assigns an instance variable for all auctions" do
      auction_1
      auction_2
      get :index
      expect(assigns(:auctions)).to eq [auction_1, auction_2]
    end
  end

  describe "#new" do
    context "user signed in" do
      before { login(user) }

      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end

      it "set an instance variable to a new auction" do
        get :new
        expect(assigns(:auction)).to be_a_new Auction
      end

    end

    context "user not signed in" do
      it "redirects to sign in page" do
        get :new
        expect(response).to redirect_to new_session_path
      end
    end
  end

  describe '#create' do
    context 'user signed in' do
      before { login(user) }

      context 'with valid parameters' do
        def valid_request
          post :create, auction: attributes_for(:auction)
        end

        it 'creates a new auction to the database' do
          expect { valid_request }.to change { Auction.count }.by(1)
        end

        it 'sets a flash message' do
          valid_request
          expect(flash[:notice]).to be
        end

        it 'redirects to the auction show page' do
          valid_request
          # this test does not take care of the edge condition where 
          # two auctions are created near the same time. oh well.
          expect(response).to redirect_to(auction_path(Auction.last))
        end

        it 'associates the current auction to the user' do
          valid_request
          expect(Auction.last.user).to eq(user)
        end
      end

      context 'with invalid parameters' do
        def invalid_request
          invalid_ends_on = DateTime.now - 33.days
          post :create, auction: {ends_on: invalid_ends_on }
        end

        it 'does not create a record in the database' do
          expect {invalid_request}.to change { Auction.count }.by(0)
        end

        it 'renders the new template' do
          invalid_request
          expect(response).to render_template(:new)
        end

        it 'sets a flash message' do
          invalid_request
          expect(flash[:alert]).to be
        end

      end
    end

    context 'user not signed in' do
      it "redirects to sign in page" do
        post :create, auction: attributes_for(:auction)
        expect(response).to redirect_to new_session_path
      end
    end
  end

end
