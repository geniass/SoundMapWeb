class MapController < ApplicationController
  def map_view
  end

  def receive
    cs = CoordinateSet.create
    puts "params: "
    puts params["coords"]
    params["coords"].each do |key,value| #the key isn't empty - the key is the value!
      cs.coordinates.new(:lat => key["lat"], :lon => key["lon"], :db => key["db"])
    end
    cs.save
    respond_to do |format|
      format.json { render :json => params }
    end
  end
end
