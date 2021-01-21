# frozen_string_literal: true

module Api
  module V2
    class SearchController < ApplicationController
      def show
        if Park.check_key(params['api_key'])
          render json: DirectionsService.only_narration(params['current'], params['to'])
        end
      end
    end
  end
end
