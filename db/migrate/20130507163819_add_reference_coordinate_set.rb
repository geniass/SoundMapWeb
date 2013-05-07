class AddReferenceCoordinateSet < ActiveRecord::Migration
  def up
    add_column :coordinates, :coordinate_set_id, :reference
  end

  def down
  end
end
