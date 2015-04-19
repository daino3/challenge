class RouteSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :bus_stops, serializer: BusStopSerializer


end