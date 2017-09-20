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
end
