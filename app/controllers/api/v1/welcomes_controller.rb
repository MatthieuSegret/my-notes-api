module API
  module V1
    class WelcomesController < ApplicationController
      skip_before_action :authenticate_user!

      def hello
        @message = params[:message] || 'world'
        render json: { message: "Hello #{@message} !" }
      end
    end
  end
end
