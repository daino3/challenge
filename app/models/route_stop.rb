class RouteStop < ActiveRecord::Base
  belongs_to :bus_stop
  belongs_to :route, counter_cache: :number_of_stops
end