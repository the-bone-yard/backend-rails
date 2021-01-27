# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User API' do
  def conn(uri)
    url = ENV['RAILS_ENGINE_DOMAIN'] + uri
    Faraday.new(url)
  end
  it 'can create a User if admin API key is included and send back User new API' do
    body = {
      email: '224@email.com',
      password: '222',
      api_key: ENV['API']
    }
    response = conn('/api/v1/user').post do |req|
      req.body = body
    end
    result = JSON.parse(response.body, symbolize_names: true)
    expect(result).to be_a(Hash)
    expect(result.keys).to eq(%i(id email password_digest api_key))

    response2 = conn('/api/v1/user').delete
    expect(response2.class).to eq([])
  end
end
