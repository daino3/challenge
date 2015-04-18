class Route < ActiveRecord::Base
  has_many :route_stops
  has_many :bus_stops, through: :route_stops

  scope :most_stops, ->() { order("number_of_stops DESC") }

  class << self
    def least_stops
      select('routes.*, COUNT(bus_stops.id) AS bus_stop_count').
      joins(:bus_stops).
      group('routes.id').
      order('bus_stop_count ASC')
    end
  end

end