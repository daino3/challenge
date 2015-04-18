class BusStop < ActiveRecord::Base

  has_many :route_stops
  has_many :routes, through: :route_stops

  belongs_to :street
  belongs_to :cross_street, class_name: 'Street'

  class << self
    def on_most_routes
      select('bus_stops.*, COUNT(route_stops.bus_stop_id) AS route_count').
      joins(:routes).
      group('bus_stops.id').
      order('route_count DESC')
    end
  end

end