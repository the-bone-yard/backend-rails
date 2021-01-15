class DirectionsService
  def self.conn
    Faraday.new('https://www.mapquestapi.com')
  end

  def self.get_directions(start, finish)
    response = conn.get('directions/v2/route') do |req|
      req.params[:key] = ENV['MAP_KEY']
      req.params[:from] = start
      req.params[:to] = finish
      req.params[:routeType] = 'fastest'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.only_narration(start, finish)
    directions = get_directions(start, finish)
    directions[:route][:legs][0][:maneuvers].map{ |step| step[:narrative]}
  end
end
