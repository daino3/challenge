require 'spec_helper'

describe Route do

  describe '#most_stops' do
    # tests added to ensure counter cache working
    let!(:route_1) { create(:route, :with_stops) }
    let!(:route_2) { create(:route, :with_stops) }
    let!(:route_3) { create(:route, :with_stops) }

    it 'does somthing awesome' do
      routes = Route.most_stops
      routes.each_with_index.all? do |route, index|
        next if index == 0
        route.number_of_stops < routes[index - 1].number_of_stops
      end
    end
  end

  describe '#least_stops' do
    let!(:route_1) { create(:route, :with_stops) }
    let!(:route_2) { create(:route, :with_stops) }
    let!(:route_3) { create(:route, :with_stops) }

    it 'sorts records by number_of_stops' do
      routes = Route.least_stops
      routes.each_with_index.all? do |route, index|
        next if index == 0
        route.number_of_stops > routes[index - 1].number_of_stops
      end
    end
  end

end
