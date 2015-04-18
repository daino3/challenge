module CivisAnalyticsApp
  class App < Sinatra::Base

    get '/' do
      slim :index, layout: true
    end

  end
end