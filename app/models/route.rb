class Route < ActiveRecord::Base
  has_many :route_stops
  has_many :bus_stops, through: :route_stops
end