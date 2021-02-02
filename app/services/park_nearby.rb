# frozen_string_literal: true

class ParkNearby
  attr_reader :name, :formatted_address, :opening_hours, :photo, :rating

  def initialize(params = {})
    @name = params.fetch(:name)
    @formatted_address = params.fetch(:vicinity, 'no address listed')
    @opening_hours = params.fetch(:opening_hours, 'opening hours not listed')
    @photo = params.fetch(:photos, 'no photos listed')
    @rating = params.fetch(:rating, 'no rating listed')
  end
end
