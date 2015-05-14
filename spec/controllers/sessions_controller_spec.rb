require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  let(:user) { create(:user) }

  describe '#new' do
    
    before { get :new }

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end

    # The test below is not needed as a new user instance 
    # need not be created.
    # it 'sets a user instance variable' do
    #   expect(assigns(:user)).to be_a_new(User)
    # end
  end

  describe '#create' do
    context 'successful login' do
      def valid_request 
        post :create, { email: user.email,
                        password: user.password }
      end

      before { valid_request }

      it 'sets the session user_id to be the id of the user' do
        expect(session[:user_id]).to eq(user.id)
      end

      it 'redirects to the homepage' do
        expect(response).to redirect_to root_path
      end

      it 'shows a flash message that they have logged in successfully' do
        expect(flash[:notice]).to be
      end
    end

    context 'unsuccessful login' do
      def invalid_request
        post :create, { email: user.email,
                        password: user.password + "lolcat"}
      end

      it "doesn't set the session user_id to user_id" do
        invalid_request
        expect(session[:user_id]).not_to be
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

  describe '#destroy' do
    def valid_request
      delete :destroy
    end

    it 'sets the session id to nil' do
      request.session[:user_id] = user.id
      valid_request
      expect(session[:user_id]).to be_nil
    end

    it 'sets a flash message' do
      valid_request
      expect(flash[:notice]).to be
    end

    it 'redirects to the root page' do
      valid_request
      expect(response).to redirect_to root_path
    end
    
  end

end
