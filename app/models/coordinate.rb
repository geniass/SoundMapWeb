class Coordinate < ActiveRecord::Base
  attr_accessible :coordinate_set_id, :db, :lat, :lon

  belongs_to :coordinate_set
end
