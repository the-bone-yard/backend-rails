require 'rails_helper'

RSpec.describe 'Places API' do
  def conn(uri)
    url = "https://maps.googleapis.com/maps/api/#{uri}"
    Faraday.new(url)
  end
  it 'can send back Google Places API with coordinates as input' do

    coords = '39.7392,-104.9903'

    radius = 2000

    response = conn('place/nearbysearch/json?').get do |req|
      req.params[:fields] = 'photos,formatted_address,name,rating,opening_hours,geometry'
      req.params[:key] = ENV['PLACE']
      req.params[:keyword] = 'dog park'
      req.params[:location] = coords
      req.params[:radius] = radius
    end
    expect(response.status).to be(200)

    park_keys = %i(business_status geometry icon name vicinity)

    json = JSON.parse(response.body, symbolize_names: true)
    expect(json.keys).to eq(%i(html_attributions results status))
    json[:results].each do |park|
      park_keys.each do |key|
        expect(park.keys.include?(key)).to be_truthy
      end
    end
  end

  it 'can get Google Place API using PlaceService using coordinates' do
    coords = '39.7392,-104.9903'
    data = {coords: coords, radius: 48000}
    result = PlaceService.get_parks(data)
    expect(result).to be_an(Array)

    park_keys = %i(business_status geometry icon name vicinity)


    result.each do |park|
      park_keys.each do |key|
        expect(park.keys.include?(key)).to be_truthy
      end
    end
  end
end
