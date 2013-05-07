class CreateCoordinateSets < ActiveRecord::Migration
  def change
    create_table :coordinate_sets do |t|
      t.timestamps :timestamp
      t.references :coordinate

      t.timestamps
    end
  end
end
