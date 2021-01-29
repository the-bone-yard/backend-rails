# frozen_string_literal: true

module Api
  module V1
    class UserController < ApplicationController
      def create
        user = User.new_user(user_params)
        render json: User.last if user != 'API KEY ERROR'
      end

      def destroy
        User.last.delete
      end

      private

      # def all_park_params
      #   params.permit(:api_key)
      # end

      # def destroy_params
      #   params.permit(:api_key, :id)
      # end

      def user_params
        params.permit(:api_key, :email, :password)
      end
    end
  end
end
