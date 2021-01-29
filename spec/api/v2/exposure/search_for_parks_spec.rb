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
    keys = %i(business_status geometry icon name photos place_id plus_code rating reference scope types user_ratings_total vicinity)
    json.each do |park|
      keys.each do |keyword|
        expect(park.keys.include?(keyword)).to eq(true)
      end
      expect(park[:rating].class == Float || Integer).to eq(true)
      expect(park[:vicinity]).to be_a(String)
      expect(park[:business_status]).to be_a(String)
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
    keys = %i(business_status geometry icon name photos place_id plus_code rating reference scope types user_ratings_total vicinity)
    json.each do |park|
      keys.each do |keyword|
        expect(park.keys.include?(keyword)).to eq(true)
      end
      expect(park[:rating].class == Float || Integer).to eq(true)
      expect(park[:vicinity]).to be_a(String)
      expect(park[:business_status]).to be_a(String)
    end
  end
end
