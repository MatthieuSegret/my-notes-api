require 'rails_helper'
 
RSpec.describe 'Users', type: :request do
  describe 'POST /api/v1/users' do
    let(:attr) { attributes_for(:user) }
    before { post '/api/v1/users', params: { user: attr } }

    it 'creates a new User' do
      expect {
        post '/api/v1/users', params: { user: attributes_for(:user) }
      }.to change(User, :count).by(1)
    end

    it 'returns header response' do
      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq('application/json')
    end

    it 'renders a JSON response with the new user' do
      expect(json[:name]).to eq(attr[:name])
      expect(json[:email]).to eq(attr[:email])
    end
  end

  describe 'PATCH /api/v1/users' do
    let(:user) { create(:user, name: 'bibi') }

    context 'with valid data' do
      it 'user is updated' do
        patch '/api/v1/users', params: { user: { name: 'Matt', current_password: '12341234' } }, headers: authenticated_header(user)
        expect(user.reload.name).to eq('Matt')
      end
    end
  end

  describe 'POST /api/v1/users/auth' do
    let!(:user) { create(:user, email: 'matt@humancoders.com') }

    context 'with valid email and valid password' do
      before { post '/api/v1/users/auth', params: { user: { email: 'matt@humancoders.com', password: '12341234' } } }

      it 'returns header response' do
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end

      it 'renders a JSON response with token' do
        expect(json).to include(:token)
      end
    end

    context 'with invalid' do
      it 'email returns error message' do
        post '/api/v1/users/auth', params: { user: { email: 'matt@humancoders.co', password: '12341234' } }
        expect(response).to have_http_status(:unauthorized)
        expect(json[:error]).to eq('Invalid email or password.')
      end

      it 'password returns error message' do
        post '/api/v1/users/auth', params: { user: { email: 'matt@humancoders.com', password: '1234123' } }
        expect(response).to have_http_status(:unauthorized)
        expect(json[:error]).to eq('Invalid email or password.')
      end
    end
  end
end
