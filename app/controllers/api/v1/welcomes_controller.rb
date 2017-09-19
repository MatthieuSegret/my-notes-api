module API
  module V1
    class WelcomesController < ApplicationController
      def hello
        @message = params[:message] || 'world'
        render json: { message: "Hello #{@message} !" }
      end
    end
  end
end