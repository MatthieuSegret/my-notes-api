require 'rails_helper'

RSpec.describe 'Welcomes', type: :request do
  describe 'GET /welcomes/hello' do
    before { get '/welcomes/hello' }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns message' do
      expect(json[:message]).to eq('Hello world !')
    end

    it 'returns message using params' do
      get '/welcomes/hello?message=Matz'
      expect(json[:message]).to eq('Hello Matz !')
    end
  end
end
