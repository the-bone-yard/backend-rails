require 'rails_helper'

RSpec.describe 'User API' do
  def conn(uri)
    url = ENV['RAILS_ENGINE_DOMAIN'] + uri
    Faraday.new(url)
  end
  it 'can create a User if admin API key is included and send back User new API' do
    body = {
      email: '222@email.com',
      password: '222',
      api_key: '2gymzMNPQSJqrkExBLz9Mgtt'
    }
    response = conn('/api/v1/users').post do |req|
      req.params[:body] = body
      req.params[:api_key] = '2gymzMNPQSJqrkExBLz9Mgtt'
    end

  end
end
