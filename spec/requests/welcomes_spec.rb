require 'rails_helper'

RSpec.describe 'Welcomes', type: :request do
  describe 'GET /welcomes/hello' do
    it 'returns status code 200' do
      get '/welcomes/hello'
      expect(response).to have_http_status(200)
    end

    it 'returns message with hello' do
      get '/welcomes/hello'
      expect(JSON.parse(response.body)['message']).to eq('Hello world !')
    end
  end
end
