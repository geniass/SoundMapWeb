class CoordinateSet < ActiveRecord::Base
  attr_accessible :timestamp

  has_many :coordinates
end
