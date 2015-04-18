require 'spec_helper'

describe BusStop do

  describe '#on_most_routes' do
    # tests added to ensure counter cache working
    let(:austin)    { create(:street, name: "AUSTIN") } # N/S
    let(:southport) { create(:street, name: "SOUTHPORT") } # N/S
    let(:davis)     { create(:street, name: "DAVIS") } # E/W
    let(:jackson)   { create(:street, name: "JACKSON") } # E/W

    let(:aus_and_dav)  { create(:bus_stop, street: austin, cross_street: davis) }
    let(:aus_and_jac)  { create(:bus_stop, street: austin, cross_street: jackson) }
    let(:sou_and_dav)  { create(:bus_stop, street: southport, cross_street: davis) }
    let(:sou_and_jac) { create(:bus_stop, street: southport, cross_street: jackson) }

    let!(:short_route)  { create(:route).bus_stops << [aus_and_dav, aus_and_jac] }
    let!(:medium_route) { create(:route).bus_stops << [aus_and_dav, aus_and_jac, sou_and_jac] }
    let!(:long_route)   { create(:route).bus_stops << [aus_and_dav, aus_and_jac, sou_and_jac, sou_and_dav] }

    it 'sorts the bus stops by presence on most routes' do
      stops = BusStop.on_most_routes
      stops.each_with_index.all? do |stop, index|
        next if index == 0
        stop.routes.count < stops[index - 1].routes.count
      end
    end
  end
end
