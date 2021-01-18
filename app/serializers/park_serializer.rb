# frozen_string_literal: true

class ParkSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attributes :id, :name, :email, :formatted_address, :lat, :lng, :photo, :rating
end
