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

  describe 'GET /api/v1/notes/:id' do
    it 'returns note by id' do
      note = create(:note)
      get '/api/v1/notes/1'
      expect(json[:title]).to eq(note.title)
      expect(json[:content]).to eq(note.content)
    end
  end

  describe 'DELETE /api/v1/notes/:id' do
    it 'destroys the requested note' do
      create(:note)
      expect { delete '/api/v1/notes/1' }.to change(Note, :count).by(-1)
    end
  end
end
