# frozen_string_literal: true

# testing that directions can be exposed, i.e.; an API call
# can be made to this app and be given directions
require 'rails_helper'

RSpec.describe 'Directions' do
  def conn(uri)
    url = ENV['RAILS_ENGINE_DOMAIN'] + uri
    Faraday.new(url)
  end
  it 'endpoint can provide array of directions with coordiantes as input' do
    current = '39.6123189,-105.0006174'
    to = '40.0149856,-105.2705456'
    response = conn('/api/v2/directions').get do |req|
      req.params[:current] = current
      req.params[:to] = to
      req.params[:api_key] = ENV['API']
    end
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to be_an(Array)
    expect(json).to_not be_empty
  end

  it 'endpoint can provide array of directions with city/state as input' do
    current = 'denver,co'
    to = 'boulder,co'
    response = conn('/api/v2/directions').get do |req|
      req.params[:current] = current
      req.params[:to] = to
      req.params[:api_key] = ENV['API']
    end
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to be_an(Array)
    expect(json).to_not be_empty
  end

  it 'can consume an API using DirectionsService' do
    start = '39.7392,-104.9903'
    finish = '40.0150,-105.2705'

    result = DirectionsService.get_directions(start, finish)
    expect(result.keys).to eq(%i[route info])
    expect(result[:route].keys.length).to eq(23)
    expect(result[:route].keys.include?(:realTime)).to eq(true)
    expect(result[:route].keys.include?(:legs)).to eq(true)
    expect(result[:route].keys.include?(:fuelUsed)).to eq(true)
    expect(result[:route].keys.include?(:options)).to eq(true)
    expect(result[:route].keys.include?(:time)).to eq(true)

    expect(result[:route][:legs][0].keys.include?(:maneuvers)).to eq(true)
    expect(result[:route][:legs][0][:maneuvers][0].keys.include?(:distance)).to eq(true)
    expect(result[:route][:legs][0][:maneuvers][0].keys.include?(:streets)).to eq(true)
    expect(result[:route][:legs][0][:maneuvers][0].keys.include?(:narrative)).to eq(true)
  end

  it 'can format directions API to match FE needs with coordinates as input' do
    start = '39.7392,-104.9903'
    finish = '40.0150,-105.2705'

    result = DirectionsService.only_narration(start, finish)

    expect(result).to be_an(Array)
  end

  it 'can format directions API to match FE needs with city/state as input' do
    start = 'denver,co'
    finish = 'boulder,co'

    result = DirectionsService.only_narration(start, finish)

    expect(result).to be_an(Array)
    expect(result).to_not be_empty
  end
end
