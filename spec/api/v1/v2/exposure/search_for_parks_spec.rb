require 'rails_helper'

describe 'api/v2/park_search' do
  def conn(uri)
    url = ENV['RAILS_ENGINE_DOMAIN'] + uri
    Faraday.new(url)
  end
  it 'GET request shows all parks near coordinates provided in body' do
    body = {
      'lat': '',
      'lng': ''
    }

    response = conn('/api/v2/park_search').get do |request|
      request.body = body
    end
    json = JSON.parse(response.body)
  end
end
