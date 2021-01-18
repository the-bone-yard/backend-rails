# frozen_string_literal: true

class CoordinateService
  def self.conn
    Faraday.new('https://www.mapquestapi.com')
  end

  def self.get_coords(info)
    coords = Coordinates.find_coords(info)
    if coords.empty?
      response = conn.get('geocoding/v1/address') do |req|
        req.params[:key] = ENV['MAP_KEY']
        req.params[:location] = info
      end
      save_coordinates(JSON.parse(response.body, symbolize_names: true))
      Coordinates.last
    else
      coords[0]
    end
  end

  def self.save_coordinates(data)
    lat = data[:results][0][:locations][0][:latLng][:lat].to_s
    lng = data[:results][0][:locations][0][:latLng][:lng].to_s
    city = data[:results][0][:providedLocation][:location].split(',')[0]
    area = data[:results][0][:providedLocation][:location].split(',')[1]
    Coordinates.create!(city: city, area: area, lat: lat, lng: lng)
  end
end
