class MapController < ApplicationController
  def map_view
  end

  def receive
    cs = CoordinateSet.create
    params["coords"].each do |key,value| #the key isn't empty - the key is the value!
      cs.coordinates.new(:lat => key["lat"], :lon => key["lon"], :db => key["db"])
    end
    cs.save
    respond_to do |format|
      format.json { render :json => params }
    end
  end

  def send_coordinates
    puts params[:id]
    coordinates = CoordinateSet.find(params[:id]).coordinates
    normalised = coordinates.where(coordinates.arel_table[:db].lt(500).and(coordinates.arel_table[:db].gt(50))).all
    puts "Max dB: " + (coordinates.all.min_by {|e| e.db }).db.to_s

    respond_to do |t|
      t.json { render :json => normalised.to_json }
    end
  end
end
