require 'rails_helper'

describe API::V1::UsersController do
  let!(:user) { create(:user, email: 'matt@humancoders.com') }
  before { post :auth, params: { user: { email: 'matt@humancoders.com', password: '12341234' } } }

  describe 'POST #create with session' do
    let!(:attr_user) { attributes_for(:user, email: 'matt@humancoders.com') }

    it('session should have auth token') { expect(session[:auth_token]).to be_present }

    it 'should have current user' do
      current_user = warden.authenticate!(scope: :user)
      expect(current_user[:name]).to eq(attr_user[:name])
      expect(current_user[:email]).to eq(attr_user[:email])
    end
  end

  describe 'DELETE #revoke_token' do
    before do
      request.headers['X-XSRF-TOKEN'] = cookies['XSRF-TOKEN']
      delete :revoke_token
    end

    it('token is nil within session') do
      expect(session[:auth_token]).to be_nil
    end

    it('user token should be nil') do
      expect(user.reload.token).to be_nil
    end
  end
end
