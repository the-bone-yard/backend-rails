# frozen_string_literal: true

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
      req.params[:api_key] = '2gymzMNPQSJqrkExBLz9Mgtt'
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
      req.params[:api_key] = '2gymzMNPQSJqrkExBLz9Mgtt'
    end
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to be_an(Array)
    expect(json).to_not be_empty
  end
end
