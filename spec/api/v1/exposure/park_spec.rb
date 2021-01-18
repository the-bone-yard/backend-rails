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

    response = conn('/api/v1/park').post do |request|
      request.body = body
    end
    json = JSON.parse(response.body)
    expect(json['name']).to eq(body[:name])
    expect(json['formatted_address']).to eq(body[:formatted_address])
    expect(json['opening_hours']).to eq(body[:opening_hours])
    expect(json['photo']).to eq(body[:photo])
    expect(json['rating']).to eq(body[:rating])
    expect(json['email']).to eq(body[:email])
    expect(json['lat']).to eq(body[:lat])
    expect(json['lng']).to eq(body[:lng])
  end
end
