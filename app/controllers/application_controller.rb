module CivisAnalyticsApp
  class App < Sinatra::Base

    use Rack::Cache,
      :verbose     => true,
      :metastore   => "file:#{APP_ROOT}/tmp/cache/rack/meta",
      :entitystore => "file:#{APP_ROOT}/tmp/cache/rack/body",
      :allow_reload     => false,
      :allow_revalidate => false

    before '/table' do
      last_route = Route.maximum(:updated_at)
      last_stop  = BusStop.maximum(:updated_at)
      last_modified(max = last_route > last_stop ? last_route : last_stop)
    end

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