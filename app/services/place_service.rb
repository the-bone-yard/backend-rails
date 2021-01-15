class PlaceService
  def self.conn
    Faraday.new('https://maps.googleapis.com/maps/api/')
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
