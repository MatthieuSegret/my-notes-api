require 'rails_helper'

RSpec.describe 'Notes', type: :request do
  describe 'GET /api/v1/notes' do
    let!(:notes) { create_list(:note, 5) }
    before { get '/api/v1/notes' }

    it 'check number of notes' do
      expect(json.count).to eq(Note.paginates_per)
    end

    it 'returns notes' do
      first_notes = notes.first(Note.paginates_per)
      expect(json.map { |n| n[:title] }).to eq(first_notes.map(&:title))
      expect(json.map { |n| n[:content] }).to eq(first_notes.map(&:content))
    end

    it 'returns next notes' do
      get '/api/v1/notes', params: {offset: Note.paginates_per}
      last_notes = notes.last(2)
      expect(json.map { |n| n[:title] }).to eq(last_notes.map(&:title))
      expect(json.map { |n| n[:content] }).to eq(last_notes.map(&:content))
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

  describe 'POST /api/v1/notes' do
    context "with valid params" do
      it "creates a new Note" do
        expect {
          post '/api/v1/notes', params: {note: attributes_for(:note)}
        }.to change(Note, :count).by(1)
      end

      it "renders a JSON response with the new note" do
        post '/api/v1/notes', params: {note: attributes_for(:note)}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')        
        expect(response.location).to eq(api_v1_note_url(Note.last))
      end
    end

    context "with invalid params" do
      before { post '/api/v1/notes', params: {note: attributes_for(:invalid_note)} }

      it "responds with errors in header" do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end

      it "renders a JSON response with errors for the new note" do
        expect(json[:title]).to eq(["can't be blank"])
        expect(json[:content]).to eq(["is too short (minimum is 10 characters)"])
      end
    end
  end

  describe "PATCH /api/v1/notes/1" do
    let(:note) { create(:note) }

    context "with valid params" do
      it "updates the requested note" do
        new_attributes = attributes_for(:another_note)
        patch api_v1_note_path(note.id), params: {note: attributes_for(:another_note)}
        note.reload
        expect(note.title).to eq(new_attributes[:title])
        expect(note.content).to eq(new_attributes[:content])
      end
    end

    context "with invalid params" do
      before { patch api_v1_note_path(note.id), params: {note: attributes_for(:invalid_note)} }

      it "responds with errors in header" do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end

      it "renders a JSON response with errors for the new note" do
        expect(json[:title]).to eq(["can't be blank"])
        expect(json[:content]).to eq(["is too short (minimum is 10 characters)"])
      end
    end
  end

  describe 'DELETE /api/v1/notes/:id' do
    it 'destroys the requested note' do
      create(:note)
      expect { delete '/api/v1/notes/1' }.to change(Note, :count).by(-1)
    end
  end
end
