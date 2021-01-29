# frozen_string_literal: true

class DirectionsSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attributes do |directions|
    require "pry"; binding.pry
  end
end
