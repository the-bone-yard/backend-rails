# frozen_string_literal: true

require 'rails_helper'

describe PlaceService do
  it 'get_parks_nearby() with coordinates' do
    data = { 'data' => '39.742043,-104.991531' }

    result = PlaceService.get_parks_nearby(data)

    expect(result).to be_an(Array)
  end

  it 'get_parks_nearby() with city/state' do
    data = { 'data' => 'denver,co' }

    result = PlaceService.get_parks_nearby(data)

    expect(result).to be_an(Array)
  end
end
