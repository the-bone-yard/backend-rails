# frozen_string_literal: true

class CoordinateService
  def self.conn
    Faraday.new('https://www.mapquestapi.com')
  end

  def self.get_coords(info)
    if Coordinates.find_coords(info).empty?
      response = conn.get('geocoding/v1/address') do |req|
        req.params[:key] = ENV['MAP_KEY']
        req.params[:location] = info
      end
      save_coordinates(JSON.parse(response.body, symbolize_names: true)[:results][0])
      Coordinates.last
    else
      Coordinates.find_coords(info)[0]
    end
  end

  def self.save_coordinates(data)
    lat = data[:locations][0][:latLng][:lat].to_s
    lng = data[:locations][0][:latLng][:lng].to_s
    city = data[:providedLocation][:location].split(',')[0]
    area = if data[:providedLocation][:location].split(',').length == 1
             'no area'
           else
             data[:providedLocation][:location].split(',')[1]
           end
    Coordinates.create!(city: city, area: area, lat: lat, lng: lng)
  end
end
