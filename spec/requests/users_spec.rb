require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:user) { build(:user) }
  let(:headers) { valid_headers.except('Authorization') }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end

  # User signup test suite
  describe 'POST /signup' do
    context 'when valid request' do
      before { post '/signup', params: valid_attributes.to_json, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Password can't be blank, Name can't be blank, Last name can't be blank, Email can't be blank, Phone can't be blank, Password digest can't be blank/)
      end
    end
  end

  describe 'GET /me' do
    let!(:user) { create :user }
    let!(:headers) { valid_headers.except('Authorization') }
    let!(:valid_attributes) do
      attributes_for(:user, password_confirmation: user.password)
    end
    context 'when the user wants his information' do
      before { get '/me', headers: headers ,params: {email:user.email}}
      it "returns the name of the user" do
        expect(json['name']).to eq(user.name)
      end
      it "returns the email of the user" do
        expect(json['email']).to eq(user.email)
      end
      it "returns the last name of the user" do
        expect(json['last_name']).to eq(user.last_name)
      end
    end
  end

end
