# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Coordinates, type: :model do
  describe 'validations' do
    it { should validate_presence_of :city }
    it { should validate_presence_of :area }
    it { should validate_presence_of :lat }
    it { should validate_presence_of :lng }
  end

  it '.find_coords(city)' do
    result = Coordinates.find_coords('denver,co')
    expect(result).to be_empty
    city = 'denver'
    area = 'co'
    lat = '1234.5678'
    lng = '-1234.5678'
    Coordinates.create!(city: city, area: area, lat: lat, lng: lng)
    expect(result).to_not be_empty
  end
end
