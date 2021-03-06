# frozen_string_literal: true

module Api
  module V1
    class ParkController < ApplicationController
      def create
        trip = Park.new_park(park_params)
        render json: Park.last if trip != 'API KEY ERROR' || trip != 'NO USER'
      end

      def destroy
        if Park.check_key(destroy_params[:api_key])
          Park.destroy(destroy_params[:id])
        else
          ErrorSerializer.new
        end
      end

      def index
        render json: UserParkSerializer.to_hash(Park.all) # if Park.check_key(all_park_params[:api_key])
      end

      private

      def all_park_params
        params.permit(:api_key)
      end

      def destroy_params
        params.permit(:api_key, :id)
      end

      def park_params
        params.permit(:api_key, :email, :formatted_address, :lat, :lng, :name, :opening_hours, :photo, :rating)
      end
    end
  end
end
