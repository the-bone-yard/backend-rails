# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Parks' do
  def conn(uri)
    url = ENV['RAILS_ENGINE_DOMAIN'] + uri
    Faraday.new(url)
  end

  it 'can create a Park through API' do
    body = {
      email: '123@email.com',
      password: '222',
      api_key: ENV['API']
    }
    response3 = conn('/api/v1/user').post do |req|
      req.body = body
    end
    expect(response3.status).to eq(200)
    body = {
      'name': 'Georges Park',
      'formatted_address': '1234 Not a Street Road, Denver, CO 80210',
      'opening_hours': 'true',
      'photo': 'not a real photo',
      'rating': '2.3',
      'email': '123@email.com',
      'lat': '123.4456',
      'lng': '-104.7764',
      'api_key': ENV['API']
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
    @id = json['id']
    response2 = conn('/api/v1/user').delete
    expect(response2.class).to eq(Faraday::Response)
  end
  it 'can delete a Park with the appropriate API key' do
    body1 = {
      email: '123@email.com',
      password: '222',
      api_key: ENV['API']
    }
    response1 = conn('/api/v1/user').post do |req| # creates a user
      req.body = body1
    end
    expect(response1.status).to eq(200)
    json1 = JSON.parse(response1.body, symbolize_names: true)
    body2 = {
      'name': 'Georges Park',
      'formatted_address': '1234 Not a Street Road, Denver, CO 80210',
      'opening_hours': 'true',
      'photo': 'not a real photo',
      'rating': '2.3',
      'email': '123@email.com',
      'lat': '123.4456',
      'lng': '-104.7764',
      'api_key': ENV['API'],
      'user_id': json1[:email]
    }

    response2 = conn('/api/v1/park').post do |request| # creates a park using user id
      request.body = body2
    end
    json2 = JSON.parse(response2.body, symbolize_names: true)
    body3 = {
      'id': json2[:id],
      'api_key': ENV['API']
    }

    response3 = conn('/api/v1/park').delete do |req| # deletes park
      req.body = body3
    end
    expect(response3.status).to eq(204)
    response4 = conn('/api/v1/user').delete
    expect(response4.class).to eq(Faraday::Response)
  end
end

describe 'Parks' do
  def conn(uri)
    url = ENV['RAILS_ENGINE_DOMAIN'] + uri
    Faraday.new(url)
  end

  it 'can get all Parks with API key' do
    body1 = {
      email: '123@email.com',
      password: '222',
      api_key: ENV['API']
    }
    response1 = conn('/api/v1/user').post do |req| # creates a user
      req.body = body1
    end
    expect(response1.status).to eq(200)
    body1 = {
      'name': 'Georges Park',
      'formatted_address': '1234 Not a Street Road, Denver, CO 80210',
      'opening_hours': 'true',
      'photo': 'not a real photo',
      'rating': '2.3',
      'email': '123@email.com',
      'lat': '123.4456',
      'lng': '-104.7764',
      'api_key': ENV['API']
    }
    conn('/api/v1/park').post do |request|
      request.body = body1
    end

<<<<<<< HEAD
    body2 = {
      'api_key': ENV['API']
    }
=======
    body = { 'api_key': '2gymzMNPQSJqrkExBLz9Mgtt' }
>>>>>>> 7b56eadc6a089a9b05f6f7eb98c1c2ab1c8a7a5e

    response = conn('/api/v1/park/all').get do |req|
      req.body = body2
    end

    json = JSON.parse(response.body, symbolize_names: true)
<<<<<<< HEAD

    expect(json.keys).to eq(%i[data])
    expect(json[:data][0].keys).to eq(%i[id type attributes])
    json[:data].each do |park|
      expect(park[:attributes].keys).to eq(%i[id name email formatted_address lat lng photo rating])
    end
    response = conn('/api/v1/user').delete
    expect(response.class).to eq(Faraday::Response)
=======
    keys = %i[name email formatted_address opening_hours photo rating lat lng]
    expect(json.keys).to eq(%i[parks])
    json[:parks].each { |park| expect(park.keys).to eq(keys) }
>>>>>>> 7b56eadc6a089a9b05f6f7eb98c1c2ab1c8a7a5e
  end
end
