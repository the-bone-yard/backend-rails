# frozen_string_literal: true

class Park < ApplicationRecord
  validates_presence_of :name, :formatted_address, :email, :lat, :lng, :photo, :rating, :opening_hours
  belongs_to :user

  def self.new_park(data)
    user = User.find_by(email: data[:email])
    if check_key(data[:api_key]) && !user.nil?
      Park.create!({
                     name: data[:name],
                     formatted_address: data[:formatted_address],
                     rating: data[:rating],
                     lat: data[:lat],
                     lng: data[:lng],
                     email: data[:email],
                     photo: data[:photo],
                     opening_hours: data[:opening_hours],
                     user_id: user.id
                   })
    elsif !find_user(data[:email]).nil?
      'API KEY ERROR'
    else
      'NO USER'
    end
  end

  def self.check_key(key)
    key == ENV['API']
  end
end
