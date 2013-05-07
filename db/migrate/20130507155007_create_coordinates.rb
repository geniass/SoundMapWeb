class CreateCoordinates < ActiveRecord::Migration
  def change
    create_table :coordinates do |t|
      t.float :lat
      t.float :lon
      t.float :db

      t.timestamps
    end
  end
end
