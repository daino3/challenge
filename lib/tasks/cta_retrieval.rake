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
    CSV.foreach(FILE_LOCATION, headers: true, header_converters: :symbol) do |row|
      binding.pry
    end
  end
end