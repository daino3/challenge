require 'spec_helper'

describe 'property_controller' do
  include FixtureLoader

  let(:route) { create(:route, :with_stops) }

  describe ' GET /' do
    it 'renders successfully' do
      get "/"

      expect(last_response.status).to eq(200)
    end
  end

  describe 'GET /bus_stops' do
    it 'returns a JSON representation of a route and its stops' do
      get "/bus_stops/#{route.id}"

      body = JSON.parse(last_response.body)

      expect(body["id"]).to eq(route.id)
      expect(body["bus_stops"].count).to eq(route.bus_stops.count)
      expect(last_response.status).to eq(200)
    end
  end

  describe 'GET /map' do
    it 'renders the google maps page with a legend of available routes' do
      ar_double = double(:active_record_double, :all => [route])
      expect(Route).to receive(:order).with("number_of_stops DESC").and_return(ar_double)

      get "/map"

      expect(last_response.status).to eq(200)
    end
  end

  describe 'GET /table' do
    it 'renders the table view page' do
      ar_double = double(:active_record_double, :all => route.bus_stops)
      expect(BusStop).to receive(:includes).with(:routes, :street, :cross_street).and_return(ar_double)

      get "/table"

      expect(last_response.status).to eq(200)
    end

    it 'is cached' do
      ar_double = double(:active_record_double, :all => route.bus_stops)
      expect(BusStop).to receive(:includes).with(:routes, :street, :cross_street).and_return(ar_double)
      route.update_attributes({updated_at: Time.now})

      get "/table"

      expect(last_response.status).to eq(200)

      get '/table', {}, {"HTTP_IF_MODIFIED_SINCE" => route.updated_at.httpdate}

      expect(last_response.status).to eq(304)
    end
  end

end