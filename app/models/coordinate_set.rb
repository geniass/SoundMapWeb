class CoordinateSet < ActiveRecord::Base
  attr_accessible :timestamp, :coordinates

  has_many :coordinates
end
