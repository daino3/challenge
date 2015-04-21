require 'net/http'
require 'csv'
require 'pry'

namespace :populate do
  FILE_LOCATION = "#{APP_ROOT}/tmp/civis_data_#{Time.now.strftime("%m-%d-%Y")}.csv"

  task cta_data: [:csv, :parse]

  desc 'get cta data'
  task :csv do
    uri = URI("https://data.cityofchicago.org/api/views/mq3i-nnqe/rows.csv?accessType=DOWNLOAD")

    data = Net::HTTP.get(uri)

    File.open(FILE_LOCATION, "wb") do |file|
      file.write data
    end
  end

  desc 'seed database with parsed CTA CSV data'
  task :parse do
    errors = 0
    CSV.foreach(FILE_LOCATION, headers: true, header_converters: :symbol) do |row|
      attributes = row.to_hash

      attributes[:cta_stop_id] = attributes.delete(:stop_id)
      attributes[:street] = Street.find_or_create_by(name: attributes.delete(:on_street))
      attributes[:cross_street] = Street.find_or_create_by(name: attributes[:cross_street])
      attributes[:alightings] = attributes[:alightings].to_f
      attributes[:boardings] = attributes[:boardings].to_f
      lat_and_long = attributes.delete(:location).scan(/(-?\d+\.\d+)+/).flatten
      attributes[:latitude]  = lat_and_long[0].to_f
      attributes[:longitude] = lat_and_long[1].to_f

      routes_as_string = attributes.delete(:routes)
      routes = begin
                routes_as_string.split(',').map do |name|
                  Route.find_or_create_by(name: name)
                end
              rescue
                errors += 1
                []
              end

      routes.each do |route|
        next if route.nil?

        if BusStop.exists?(cta_stop_id: attributes[:cta_stop_id])
          route.bus_stops << BusStop.find_by(cta_stop_id: attributes[:cta_stop_id])
        else
          route.bus_stops << BusStop.create(attributes)
        end
      end
    end
  end
end