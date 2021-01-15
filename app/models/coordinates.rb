class Coordinates < ApplicationRecord
  validates_presence_of :city, :area, :lat, :lng

  def self.find_coords(info)
    city = info.split(',')[0]
    Coordinates.where(city: city)
  end
end
