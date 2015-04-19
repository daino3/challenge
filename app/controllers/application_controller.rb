module CivisAnalyticsApp
  class App < Sinatra::Base

    get '/map' do
      @routes = Route.order("number_of_stops DESC").all
      slim :map, layout: true
    end

    get '/' do
      slim :index, layout: true
    end

    get '/table' do
      @stops = BusStop.includes(:routes, :street, :cross_street).all
      slim :table, layout: true
    end

    get '/bus_stops/:route_id' do
      content_type :json

      route = Route.includes(:bus_stops => [:street, :cross_street]).find(params[:route_id])

      RouteSerializer.new(route, root: false).to_json
    end

  end
end