# frozen_string_literal: true

class UserParkSerializer
  def self.to_hash(data)
    {
      'parks' => all_parks(data)
    }
  end

  def self.all_parks(parks)
    parks.map do |park|
      {
        'name' => park.name,
        'email' => park.email,
        'formatted_address' => park.formatted_address,
        'opening_hours' => park.opening_hours,
        'photo' => park.photo,
        'rating' => park.rating,
        'lat' => park.lat,
        'lng' => park.lng
      }
    end
  end
end
