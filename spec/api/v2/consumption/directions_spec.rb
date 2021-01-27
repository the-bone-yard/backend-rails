# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Map API call' do
  def conn(uri)
    url = "https://www.mapquestapi.com#{uri}"
    Faraday.new(url)
  end

  it 'gets route when given a start and finish location' do
    start = 'denver,co'
    finish = 'boulder,co'

    response = conn('/directions/v2/route').get do |req|
      req.params[:key] = ENV['MAP_KEY']
      req.params[:from] = start
      req.params[:to] = finish
      req.params[:routeType] = 'fastest'
    end

    expect(response.status).to eq(200)
    json = JSON.parse(response.body)

    expect(json.keys).to eq(%w[route info])
    expect(json['route'].keys.length).to eq(23)
    expect(json['route'].keys.include?('realTime')).to eq(true)
    expect(json['route'].keys.include?('legs')).to eq(true)
    expect(json['route'].keys.include?('fuelUsed')).to eq(true)
    expect(json['route'].keys.include?('options')).to eq(true)
    expect(json['route'].keys.include?('time')).to eq(true)

    expect(json['route']['legs'][0].keys.include?('maneuvers')).to eq(true)
    expect(json['route']['legs'][0]['maneuvers'][0].keys.include?('distance')).to eq(true)
    expect(json['route']['legs'][0]['maneuvers'][0].keys.include?('streets')).to eq(true)
    expect(json['route']['legs'][0]['maneuvers'][0].keys.include?('narrative')).to eq(true)
  end

  it 'can get directions when given coordinates as well' do
    start = '39.7392,-104.9903'
    finish = '40.0150,-105.2705'

    response = conn('/directions/v2/route').get do |req|
      req.params[:key] = ENV['MAP_KEY']
      req.params[:from] = start
      req.params[:to] = finish
      req.params[:routeType] = 'fastest'
    end

    expect(response.status).to eq(200)
    json = JSON.parse(response.body)

    expect(json.keys).to eq(%w[route info])
    expect(json['route'].keys.length).to eq(23)
    expect(json['route'].keys.include?('realTime')).to eq(true)
    expect(json['route'].keys.include?('legs')).to eq(true)
    expect(json['route'].keys.include?('fuelUsed')).to eq(true)
    expect(json['route'].keys.include?('options')).to eq(true)
    expect(json['route'].keys.include?('time')).to eq(true)

    expect(json['route']['legs'][0].keys.include?('maneuvers')).to eq(true)
    expect(json['route']['legs'][0]['maneuvers'][0].keys.include?('distance')).to eq(true)
    expect(json['route']['legs'][0]['maneuvers'][0].keys.include?('streets')).to eq(true)
    expect(json['route']['legs'][0]['maneuvers'][0].keys.include?('narrative')).to eq(true)
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

  it 'can format directions API to match FE needs' do
    start = '39.7392,-104.9903'
    finish = '40.0150,-105.2705'

    result = DirectionsService.only_narration(start, finish)

    expect(result).to be_an(Array)
  end
end
