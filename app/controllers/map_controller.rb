class MapController < ApplicationController
  def map_view
  end

  def receive
    cs = CoordinateSet.create
    params[:coords].each do |key,value|
      puts value
      cs.coordinates.new(value)
    end
    respond_to do |format|
      format.json { render :json => params }
    end
  end
end
