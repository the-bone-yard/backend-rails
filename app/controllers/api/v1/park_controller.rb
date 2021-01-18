module Api
  module V1
    class ParkController < ApplicationController
      def create
        trip = Park.new_park(park_params)
        if trip != 'API KEY ERROR'
          render json: Park.last
        end
      end

      private

      def park_params
        params.permit(:api_key, :email, :formatted_address, :lat, :lng, :name, :opening_hours, :photo, :rating)
      end
    end
  end
end
