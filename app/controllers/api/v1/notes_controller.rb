module API
  module V1
    class NotesController < ApplicationController
      skip_before_action :authenticate_user!, only: [:index, :search, :show]
      before_action :set_note, only: [:show, :update, :destroy]
      before_action :is_owner, only: [:update, :delete]

      # GET /api/v1/notes
      def index
        if user_signed_in?
          @notes = current_user.notes.paginate(params[:offset])
        else
          @notes = Note.paginate(params[:offset])
        end
      end

      # GET /api/v1/notes/search
      def search
        if user_signed_in?
          @notes = current_user.notes.search(params[:keywords]).paginate(params[:offset])
        else
          @notes = Note.search(params[:keywords]).paginate(params[:offset])
        end
        render :index
      end

      # GET /api/v1/notes/1
      def show
      end

      # POST /api/v1/notes
      def create
        @note = Note.new(note_params)
        @note.user = current_user

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

      def is_owner
        if @note.user != current_user
          render json: { error: "You can not modify someone else's note" }, status: :forbidden
        end
      end

      def note_params
        params.require(:note).permit(:title, :content)
      end
    end
  end
end
