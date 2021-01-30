# frozen_string_literal: true

require 'rails_helper'

describe 'api/v2/park_search' do
  def conn(uri)
    url = ENV['RAILS_ENGINE_DOMAIN'] + uri
    Faraday.new(url)
  end
  it 'GET request shows all parks near coordinates provided in body' do
    body = {
      'data': '39.742043,-104.991531'
    }

    response = conn('/api/v2/park_search').get do |request|
      request.body = body
    end
    json = JSON.parse(response.body, symbolize_names: true)

    json[:parks].each do |park|
      expect(park[:rating].instance_of?(Float)).to eq(true)
      expect(park[:formatted_address]).to be_a(String)
      expect(park[:photo]).to be_an(Array)
    end
  end

  it 'GET request shows all parks near city/state provided in body' do
    body = {
      'data': 'denver,co'
    }

    response = conn('/api/v2/park_search').get do |request|
      request.body = body
    end
    json = JSON.parse(response.body, symbolize_names: true)

    json[:parks].each do |park|
      expect(park[:rating].instance_of?(Float)).to eq(true)
      expect(park[:formatted_address]).to be_a(String)
      expect(park[:photo]).to be_an(Array)
    end
  end
end


describe 'Park Serializer' do
  it 'will format info correctly' do
    parks_reformatted = []
    parks = PlaceService.get_parks_nearby({'data' => 'denver,co'})
    result = ParkSerializer.to_hash(parks)
    expect(result).to be_a(Hash)
  end
end
