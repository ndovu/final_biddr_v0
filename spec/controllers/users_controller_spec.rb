require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe '#new' do
    it 'instantiates a new user variable' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe '#create' do
    context 'with valid parameters' do
      it 'creates a user in the database' do
        expect do
          post :create, {user: {
                          first_name: 'Noel',
                          last_name: 'Bacani',
                          email: 'noel.bacani@gmail.com',
                          password: 'abcd1234',
                          password_confirmation: 'abcd1234'
                        }}
        end.to change { User.count }.by(1)
      end
    end

    context 'with invalid parameters' do
      def invalid_request
          post :create, {user: {
                          password: 'abcd1234',
                          password_confirmation: 'abcd1234'
                        }}
      end

      it 'does not create a user record in the database' do
        expect { invalid_request }.to_not change { User.count }
      end

      it 'renders the new template' do
        invalid_request
        expect(response).to render_template(:new)
      end

      it 'sets an alert flash message' do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end
end