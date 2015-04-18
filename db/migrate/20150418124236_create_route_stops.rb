class CreateRouteStops < ActiveRecord::Migration
  def change
    create_table :route_stops do |t|
      t.belongs_to :route
      t.belongs_to :bus_stop
    end
  end
end
