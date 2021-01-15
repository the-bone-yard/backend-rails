class CoordinateService
  def self.conn
    Faraday.new('https://www.mapquestapi.com')
  end

  def self.convert(info)
    coords = Coordinates.find_coords(info)
    if coords == []
      response = conn.get('geocoding/v1/address') do |req|
        req.params[:key] = ENV['MAP_KEY']
        req.params[:location] = info
      end
      json = JSON.parse(response.body, symbolize_names: true)
      save_coordinates(json)
      return json
    else
      coords
    end
  end
end
