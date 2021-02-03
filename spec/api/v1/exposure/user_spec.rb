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
    expect(result.keys).to eq(%i[id email password_digest api_key])

    response2 = conn('/api/v1/user').delete
    expect(response2.class).to eq(Faraday::Response)
  end
end

describe 'User API' do
  describe 'login' do
    def conn(uri)
      url = ENV['RAILS_ENGINE_DOMAIN'] + uri
      Faraday.new(url)
    end
    it 'can login with correct credentials' do
      new_user_data = {
        email: '224@email.com',
        password: '222',
        api_key: ENV['API']
      }
      conn('/api/v1/user').post do |req|
        req.body = new_user_data
      end

      login_user = {
        email: '224@email.com',
        password: '222'
      }
      response2 = conn('/api/v1/user/login').get do |req|
        req.body = login_user
      end
      user_logged_in = JSON.parse(response2.body, symbolize_names: true)
      expect(user_logged_in.keys).to eq(%i[id email password_digest api_key])

      remove_user = conn('/api/v1/user').delete
      expect(remove_user.class).to eq(Faraday::Response)
    end
  end
end
