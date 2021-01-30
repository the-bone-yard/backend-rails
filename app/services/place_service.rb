# frozen_string_literal: true

class PlaceService
  def self.conn
    Faraday.new('https://maps.googleapis.com/maps/api/')
  end

  def self.get_parks_nearby(data)
    parks = []
    radius = 48_000
    info = if data['data'].split(',')[0].to_f != 0.0
             data['data']
           else
             convert_city_state_to_coordiantes(data['data'])
           end
    result = get_parks({ coords: info, radius: radius })
    result.each{ |park| parks << ParkNearby.new(park)}
    parks
  end

  def self.convert_city_state_to_coordiantes(data)
    "#{CoordinateService.get_coords(data).lat},#{CoordinateService.get_coords(data).lng}"
  end

  def self.get_parks(info)
    coords = info[:coords]
    radius = info[:radius]
    response = conn.get('place/nearbysearch/json?') do |req|
      req.params[:fields] = 'photos,formatted_address,name,rating,opening_hours,geometry'
      req.params[:key] = ENV['PLACE']
      req.params[:keyword] = 'dog park'
      req.params[:location] = coords
      req.params[:radius] = radius
    end
    JSON.parse(response.body, symbolize_names: true)[:results]
  end
end
