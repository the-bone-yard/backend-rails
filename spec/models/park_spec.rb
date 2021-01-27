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
        'api_key': '2gymzMNPQSJqrkExBLz9Mgtt'
      }
      Park.new_park(data)
      require "pry"; binding.pry
    end

    it 'can check API key and send back an error if not validated' do

    end
  end
end
