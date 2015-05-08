require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do
  let(:user)     { create(:user) }
  let(:auction_1) { create(:auction, user: user) }
  let(:auction_2) { create(:auction) }

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

  describe "#show" do
    before { get :show, id: auction_1.id }

    it "renders the show template" do
      expect(response).to render_template :show 
    end

    it "sets an instance variable with the auction whose id is passed" do
      expect(assigns(:auction)).to eq(auction_1)
    end
  end

  describe "#edit" do

    context "user not signed in" do
      before { get :edit, id: auction_1.id }

      it "redirects to sign in page" do
        post :create, auction: attributes_for(:auction)
        expect(response).to redirect_to new_session_path
      end
    end

    context "owner user of the auction is signed in" do
      before { login(user) }
      before { get :edit, id: auction_1.id }
      
      it "renders the edit template for the auction" do
        expect(response).to render_template(:edit)
      end

      it "sets an auction instance variable with the id passed" do
        expect(assigns(:auction)).to eq(auction_1)
      end
    end

    context "with non-owner user signed in" do
      # Comment the before action below to make the test fail
      before { login(user) }

      it "raises an error if a non-owners tries to edit" do
        expect { get :edit, id: auction_2.id }.to raise_error
      end
    end
  end

  describe "#update" do
    context "with user not signed in" do
      it "redirects new session path" do
        patch :update, id: auction_1.id, auction: {title: Faker::Commerce.product_name}
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with owner user signed in" do
      before { login(user) }

      def valid_attributes(new_attributes = {})
        attributes_for(:auction).merge(new_attributes)
      end

      context "with valid attributes" do
        before do
          patch :update, id:       auction_1.id, 
                         auction:  valid_attributes(title: 'Product Name Test')
        end

        it "updates the record in the database" do
          expect(auction_1.reload.title).to eq('Product Name Test')
        end

        it "redirects to the auction show page" do
          expect(response).to redirect_to(auction_path(auction_1))
        end

        it "sets a flash message" do
          expect(flash[:notice]).to be
        end
      end

      context "with invalid attributes" do
        before do
          patch :update, id:       auction_1.id, 
                         auction: valid_attributes(title: nil)
        end

        it "doesn't update the record in the database" do
          expect(auction_1.reload.title).to_not eq("asdf")
        end

        it "renders the edit template" do
          expect(response).to render_template(:edit)
        end

        it "sets a flash message" do
          expect(flash[:alert]).to be
        end
      end
    end

    context "with non-owner user signed in" do
      before { login(user) }

      it "raises an error" do
        expect do
          patch :update, id: auction_2.id, auction: attributes_for(:auction)
        end.to raise_error
      end
    end
  end
end
