class Coordinate < ActiveRecord::Base
  attr_accessible :db, :lat, :lon, :coordinate_set_id

  belongs_to :coordinate_set
end
