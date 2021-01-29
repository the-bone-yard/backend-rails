# frozen_string_literal: true

module Api
  module V2
    class SearchController < ApplicationController
      def show
        if params['api_key'] == ENV['API']
          render json: DirectionsService.only_narration(params['current'], params['to']).to_json
        end
      end

      def parks
        render json: PlaceService.reformat_data_if_not_coordinates(location_params).to_json
      end

      private

      def location_params
        params.permit(:data)
      end
    end
  end
end
