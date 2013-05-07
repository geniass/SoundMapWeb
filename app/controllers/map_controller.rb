class MapController < ApplicationController
  def map_view
  end

  def receive
    puts params
    return params.to_json
  end
end
