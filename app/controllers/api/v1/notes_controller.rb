module API
  module V1
    class NotesController < ApplicationController
      before_action :set_note, only: [:show, :update, :destroy]

      # GET /api/v1/notes
      def index
        @notes = Note.paginate(params[:offset])
      end

      # GET /api/v1/notes/search
      def search
        @notes = Note.search(params[:keywords]).paginate(params[:offset])
        render :index
      end

      # GET /api/v1/notes/1
      def show
      end

      # POST /api/v1/notes
      def create
        @note = Note.new(note_params)

        if @note.save
          render :show, status: :created, location: api_v1_note_url(@note)
        else
          render json: @note.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/notes/1
      def update
        if @note.update(note_params)
          render :show, status: :ok, location: api_v1_note_url(@note)
        else
          render json: @note.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/notes/1
      def destroy
        @note.destroy
        head :no_content
      end

      private

      def set_note
        @note = Note.find(params[:id])
      end

      def note_params
        params.require(:note).permit(:title, :content)
      end
    end
  end
end
