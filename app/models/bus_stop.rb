class BusStop < ActiveRecord::Base

  has_many :route_stops
  has_many :routes, through: :route_stops

  belongs_to :street
  belongs_to :cross_street, class_name: 'Street'

  attr_accessor :latitude, :longitude, :street, :cross_street

end