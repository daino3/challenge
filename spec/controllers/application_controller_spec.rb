require 'spec_helper'

describe 'property_controller' do
  include FixtureLoader

  describe '#index' do
    it 'does something' do
      get "/"

      expect(last_response.status).to eq(200)
    end
  end

  describe '#bus_stops' do
    let(:route) { create(:route, :with_stops) }

    it 'does something' do
      get "bus_stops/#{route.id}"

      body = JSON.parse(last_response.body)

      expect(body["id"]).to eq(route.id)
      expect(body["bus_stops"].count).to eq(route.bus_stops.count)
      expect(last_response.status).to eq(200)
    end
  end

end