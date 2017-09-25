module API
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user!, only: [:auth, :refresh_token]

      def auth
        user = User.find_by(email: params[:user][:email])
        if user.present? && user.valid_password?(params[:user][:password])
          session[:refresh_token] = user.generate_refresh_token!
          render json: { token: user.generate_jwt_token, refresh_token: user.refresh_token }, status: :created
        else
          render json: { error: 'Invalid email or password.' }, status: :unauthorized
        end
      end

      def refresh_token
        refresh_token = session[:refresh_token] || params[:refresh_token]
        user = refresh_token.present? ? User.find_by(refresh_token: refresh_token) : nil
        if user.present?
          render json: { token: user.generate_jwt_token }, status: :created
        else
          render json: { error: 'Invalid refresh token.' }, status: :unauthorized
        end
      end

      def revoke_refresh_token
        session[:refresh_token] = nil
        current_user.update(refresh_token: nil)
        sign_out current_user
        head :ok
      end
    end
  end
end
