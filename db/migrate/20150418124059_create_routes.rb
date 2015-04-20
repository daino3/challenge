class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :name
      t.integer :number_of_stops, default: 0

      t.timestamps
    end
  end
end
