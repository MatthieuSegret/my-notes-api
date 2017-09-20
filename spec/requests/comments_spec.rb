require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  describe 'POST /api/v1/notes/:note_id/comments' do
    let(:note) { create(:note) }
    
    context 'with valid params' do
      it 'creates a new Comment' do
        expect do
          post "/api/v1/notes/#{note.id}/comments", params: { comment: attributes_for(:comment) }
        end.to change(note.comments, :count).by(1)
      end

      it 'renders a JSON response with the new note' do
        post "/api/v1/notes/#{note.id}/comments", params: { comment: attributes_for(:comment) }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(note.comments.last.body).to eq(attributes_for(:comment)[:body])
      end
    end

    context "with invalid params" do
      before { post "/api/v1/notes/#{note.id}/comments", params: { comment: attributes_for(:invalid_comment) } }

      it "responds with errors in header" do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end

      it "renders a JSON response with errors for the new note" do
        expect(json[:body]).to eq(["can't be blank"])
      end
    end
  end
end
