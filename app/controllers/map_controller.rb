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
    puts CoordinateSet.find(params[:id]).coordinates.all.to_json

    respond_to do |t|
      t.json { render :json => CoordinateSet.find(params[:id]).coordinates.all.to_json }
    end
  end
end
