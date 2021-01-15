# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GeoCode API call' do
  def conn(uri)
    url = "https://www.mapquestapi.com#{uri}"
    Faraday.new(url)
  end

  it 'gets coordinates of a specific location' do
    info = 'denver,co'

    response = conn('/geocoding/v1/address').get do |req|
      req.params[:key] = ENV['MAP_KEY']
      req.params[:location] = info
    end
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)

    expect(json.keys).to eq(%w[info options results])
    expect(json['info'].keys).to eq(%w[statuscode copyright messages])

    json['info'].each do |key, value|
      case key
      when 'statuscode'
        expect(value).to be_an(Integer)
      when 'copyright'
        expect(value).to be_a(Hash)
      when 'messages'
        expect(value).to be_an(Array)
      end
    end

    json['results'][0].each do |key, value|
      if key == 'providedLocation'
        value.each do |k, v|
          expect(k).to eq('location')
          expect(v).to eq(info.to_s)
        end
      else
        expect(value[0].keys.length).to eq(22)
        expect(value[0].keys.include?('latLng')).to eq(true)
        expect(value[0]['latLng']).to be_a(Hash)
        expect(value[0]['latLng'].keys).to eq(%w[lat lng])
        expect(value[0]['latLng'].values.all?(Float)).to eq(true)
      end
    end
  end

  it 'can convert city/state to coordinates using CoordinateService' do
    city = 'denver,co'

    result = CoordinateService.convert(city)
    expect(result).to be_a(String)
    expect(result.split(', ')[0].to_f).to be_a(Float)
    expect(result.split(', ')[1].to_f).to be_a(Float)
  end
end
