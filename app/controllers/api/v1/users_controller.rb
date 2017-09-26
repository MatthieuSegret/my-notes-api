module API
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user!, only: [:auth]

      def auth
        user = User.find_by(email: params[:user][:email])
        if user.present? && user.valid_password?(params[:user][:password])
          session[:auth_token] = user.generate_token!
          render json: { token: user.token }, status: :created
        else
          render json: { error: 'Invalid email or password.' }, status: :unauthorized
        end
      end

      def revoke_token
        session[:auth_token] = nil
        current_user.update(token: nil)
        sign_out current_user 
        head :ok
      end
    end
  end
end
