class MapController < ApplicationController
  def map_view
  end

  def receive
    puts params
    respond_to do |format|
      format.json { render :json => params }
    end
  end
end
