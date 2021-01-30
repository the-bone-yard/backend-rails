# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Parks' do
  def conn(uri)
    url = ENV['RAILS_ENGINE_DOMAIN'] + uri
    Faraday.new(url)
  end

  it 'can create a Park through API' do
    body = {
      'name': 'Georges Park',
      'formatted_address': '1234 Not a Street Road, Denver, CO 80210',
      'opening_hours': 'true',
      'photo': 'not a real photo',
      'rating': '2.3',
      'email': '123@email.com',
      'lat': '123.4456',
      'lng': '-104.7764',
      'api_key': '2gymzMNPQSJqrkExBLz9Mgtt'
    }

    response = conn('/api/v1/park').post { |request| request.body = body }
    json = JSON.parse(response.body)
    expect(json['name']).to eq(body[:name])
    expect(json['formatted_address']).to eq(body[:formatted_address])
    expect(json['opening_hours']).to eq(body[:opening_hours])
    expect(json['photo']).to eq(body[:photo])
    expect(json['rating']).to eq(body[:rating])
    expect(json['email']).to eq(body[:email])
    expect(json['lat']).to eq(body[:lat])
    expect(json['lng']).to eq(body[:lng])
    @@id = json['id']
  end
  it 'can delete a Park with the appropriate API key' do
    body = { 'id': @@id, 'api_key': '2gymzMNPQSJqrkExBLz9Mgtt' }

    response = conn('/api/v1/park').delete do |req|
      req.body = body
    end
    expect(response.status).to eq(204)
  end
end

describe 'Parks' do
  def conn(uri)
    url = ENV['RAILS_ENGINE_DOMAIN'] + uri
    Faraday.new(url)
  end

  it 'can get all Parks with API key' do
    body = {
      'name': 'Georges Park',
      'formatted_address': '1234 Not a Street Road, Denver, CO 80210',
      'opening_hours': 'true',
      'photo': 'not a real photo',
      'rating': '2.3',
      'email': '123@email.com',
      'lat': '123.4456',
      'lng': '-104.7764',
      'api_key': '2gymzMNPQSJqrkExBLz9Mgtt'
    }

    body = { 'api_key': '2gymzMNPQSJqrkExBLz9Mgtt' }

    response = conn('/api/v1/park/all').get do |req|
      req.body = body
    end

    json = JSON.parse(response.body, symbolize_names: true)
    keys = %i[name email formatted_address opening_hours photo rating lat lng]
    expect(json.keys).to eq(%i[parks])
    json[:parks].each { |park| expect(park.keys).to eq(keys) }
  end
end
