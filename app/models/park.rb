# frozen_string_literal: true

class Park < ApplicationRecord
  validates_presence_of :name, :formatted_address, :email, :lat, :lng, :photo, :rating, :opening_hours

  def self.new_park(data)
    if check_key(data['api_key'])
      Park.create!({
                     name: data['name'],
                     formatted_address: data['formatted_address'],
                     rating: data['rating'],
                     lat: data['lat'],
                     lng: data['lng'],
                     email: data['email'],
                     photo: data['photo'],
                     opening_hours: data['opening_hours']
                   })
    else
      'API KEY ERROR'
    end
  end

  def self.check_key(key)
    key == ENV['API']
  end
end
