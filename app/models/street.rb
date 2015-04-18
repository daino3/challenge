class Street < ActiveRecord::Base

  has_many :bus_stops
end