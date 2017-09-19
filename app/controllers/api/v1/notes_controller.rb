module API
  module V1
    class NotesController < ApplicationController
      before_action :set_note, only: [:show, :destroy]

      # GET /api/v1/notes
      def index
        @notes = Note.all
        render json: @notes
      end

      # GET /api/v1/notes/1
      def show
        render json: @note
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
    end
  end
end
