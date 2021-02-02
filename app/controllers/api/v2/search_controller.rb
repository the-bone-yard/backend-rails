# frozen_string_literal: true

module Api
  module V2
    class SearchController < ApplicationController
      def show
        if params['api_key'] == ENV['API']
          render json: DirectionsService.only_narration(params['current'], params['to']).to_json
        else
          'API ERROR'
        end
      end
    end
  end
end
