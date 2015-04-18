class CreateBusStops < ActiveRecord::Migration
  def change
    create_table :bus_stops do |t|
      t.belongs_to :street
      t.belongs_to :cross_street
      t.float :longitude
      t.float :latitude
      t.float :boardings
      t.float :alightings
      t.string :daytype
      t.date :month_beginning
    end
  end
end
