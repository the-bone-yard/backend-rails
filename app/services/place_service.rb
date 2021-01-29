# frozen_string_literal: true

class PlaceService
  def self.conn
    Faraday.new('https://maps.googleapis.com/maps/api/')
  end

  def self.reformat_data_if_not_coordinates(data)
    radius = 48000
    if data["data"].split(',')[0].to_f != 0.0
      get_parks({coords: data['data'], radius: radius})
    else
      coordinate_object = CoordinateService.get_coords(data['data'])
      get_parks({coords: "#{coordinate_object.lat},#{coordinate_object.lng}", radius: radius})
    end
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
