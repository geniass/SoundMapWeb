class MapController < ApplicationController
  def map_view
  end

  def receive
    cs = CoordinateSet.create
    puts params[:coords]
    params[:coords].each do |key,value|
      puts value
      cs.coordinates.new(value)
    end
    cs.save
    respond_to do |format|
      format.json { render :json => params }
    end
  end
end
