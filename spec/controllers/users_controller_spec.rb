require 'rails_helper'

describe API::V1::UsersController do
  let!(:user) { create(:user, email: 'matt@humancoders.com') }
  let!(:token) do
    post :auth, params: { user: { email: 'matt@humancoders.com', password: '12341234' } }
    json[:token]
  end

  describe 'POST #refresh_token with session' do
    it('returns jwt token') do
      post :refresh_token
      expect(json).to include(:token)
    end
  end

  describe 'DELETE #revoke_refresh_token' do
    before do
      request.headers['Authorization'] = "Bearer #{token}"
      delete :revoke_refresh_token
    end

    it('refresh_token is nil within session') do
      expect(session[:refresh_token]).to be_nil
    end

    it('user has not refresh_token') do
      expect(user.reload.refresh_token).to be_nil
    end
  end
end
