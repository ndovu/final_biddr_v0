require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  let(:user) { create(:user) }

  describe '#new' do
    
    before { get :new }

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end

    it 'sets a user instance variable' do
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe '#create' do
    context 'successful login' do
      def valid_request 
        post :create, user: { email: user.email,
                              password: user.password}
      end

      before { valid_request }

      # it 'sets the session user_id to be the id of the user' do
      #   expect(session[:user_id]).to eq(user.id)
      # end

    end

    context 'unsuccessful login' do

    end
  end

end
