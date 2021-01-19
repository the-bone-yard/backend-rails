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
    end
    require "pry"; binding.pry
  end
end
