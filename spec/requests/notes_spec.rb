require 'rails_helper'

RSpec.describe 'Notes', type: :request do
  describe 'GET /api/v1/notes' do
    let!(:notes) { create_list(:note, 5) }
    before { get '/api/v1/notes' }

    it 'returns 5 notes' do
      expect(json.count).to eq(5)
    end

    it 'returns 5 notes' do
      expect(json.map { |n| n[:title] }).to eq(notes.map(&:title))
      expect(json.map { |n| n[:content] }).to eq(notes.map(&:content))
    end
  end
end
