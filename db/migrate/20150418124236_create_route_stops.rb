class CreateRouteStops < ActiveRecord::Migration
  def change
    create_table :route_stops do |t|
      t.belongs_to :route
      t.belongs_to :bus_stop

      t.timestamps
    end

    add_index :route_stops, [:route_id, :bus_stop_id]
  end
end
