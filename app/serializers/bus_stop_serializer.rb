class BusStopSerializer < ActiveModel::Serializer
  attributes :street,
    :cross_street,
    :longitude,
    :latitude,
    :boardings,
    :alightings,
    :daytype,
    :month_beginning

end