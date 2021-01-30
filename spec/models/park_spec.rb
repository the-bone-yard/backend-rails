# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Park, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :formatted_address }
    it { should validate_presence_of :opening_hours }
    it { should validate_presence_of :photo }
    it { should validate_presence_of :rating }
    it { should validate_presence_of :email }
    it { should validate_presence_of :lat }
    it { should validate_presence_of :lng }
  end
end

describe Park, type: :model do
  describe 'methods' do
    it 'new_park() with incorrect API key' do
      data = {
        'name' => 'fake park',
        'formatted_address' => 'fake address',
        'rating' => 'rating',
        'lat' => 'lat',
        'lng' => 'lng',
        'email' => 'email@fake.com',
        'photo' => 'no photo',
        'opening_hours' => 'open',
        'api_key' => '222'
      }
      result = Park.new_park(data)
      expect(result).to eq('API KEY ERROR')
    end
  end
end

describe Park, type: :model do
  describe 'methods' do
    it 'new_park() with correct API key' do
      data = {
        'name' => 'fake park',
        'formatted_address' => 'fake address',
        'rating' => 'rating',
        'lat' => 'lat',
        'lng' => 'lng',
        'email' => 'email@fake.com',
        'photo' => 'no photo',
        'opening_hours' => 'open',
        'api_key' => (ENV['API']).to_s
      }
      result = Park.new_park(data)
      expect(result).to_not eq('API KEY ERROR')
    end
  end
end
