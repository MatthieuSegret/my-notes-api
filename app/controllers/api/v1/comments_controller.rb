module API
  module V1
    class CommentsController < ApplicationController
      # POST /api/v1/comments
      def create
        note = Note.find(params[:note_id])
        @comment = note.comments.build(comment_params)

        if @comment.save
          render json: @comment, status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      def comment_params
        params.require(:comment).permit(:body)
      end
    end
  end
end
