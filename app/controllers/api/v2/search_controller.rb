# frozen_string_literal: true

module Api
  module V2
    class SearchController < ApplicationController
      def show
        if Park.check_key(params['api_key'])
          render json: {'narration': DirectionsService.only_narration(params['current'], params['to'])}
        else
          render json: {'API KEY ERROR'}
        end
      end
    end
  end
end
