module API
  module V1
    class NotesController < ApplicationController
      before_action :set_note, only: [:show, :update, :destroy]

      # GET /api/v1/notes
      def index
        @notes = Note.paginate(params[:offset])
        render json: @notes
      end

      # GET /api/v1/notes/1
      def show
        render json: @note
      end

      # POST /api/v1/notes
      def create
        @note = Note.new(note_params)

        if @note.save
          render json: @note, status: :created, location: api_v1_note_url(@note)
        else
          render json: @note.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/notes/1
      def update
        if @note.update(note_params)
          render json: @note
        else
          render json: @note.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/notes/1
      def destroy
        @note.destroy
        render json: @note
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
