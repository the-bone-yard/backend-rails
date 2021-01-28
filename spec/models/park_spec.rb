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

RSpec.describe User, type: :model do
  describe '.check_key()' do
    it 'can check API key and create a Park if validated' do
      expect(Park.all).to be_empty

      data = {
        formatted_address: '1234 Nope',
        name: 'The Dude Ranch',
        rating: '33',
        lat: '33.098',
        lng: '-104.55',
        email: '222@email.com',
        photo: 'no photos please',
        opening_hours: 'yes',
        api_key: ENV['API']
      }

      expect { Park.new_park(data) }.to change { Park.all.count }.by(1)
    end

    it 'can check API key and send back an error if not validated' do
      expect(Park.all).to be_empty
      data = {
        formatted_address: '1234 Nope',
        name: 'The Dude Ranch',
        rating: '33',
        lat: '33.098',
        lng: '-104.55',
        email: '222@email.com',
        photo: 'no photos please',
        opening_hours: 'yes',
        api_key: '2'
      }
      result = Park.new_park(data)

      expect(result).to eq('API KEY ERROR')
    end
  end
end
