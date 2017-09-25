module API
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user!, only: [:auth]

      def auth
        user = User.find_by(email: params[:user][:email])
        if user.present? && user.valid_password?(params[:user][:password])
          render json: { token: JsonWebToken.encode(sub: user.id, name: user.name, email: user.email) }
        else
          render json: { error: 'Invalid email or password.' }, status: :unauthorized
        end
      end
    end
  end
end
