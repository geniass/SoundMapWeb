class MapController < ApplicationController
  def map_view
  end

  def receive
    cs = CoordinateSet.create
    puts "params: "
    puts params["coords"]
    params["coords"].each do |key,value|
      puts value
      puts "MOAR"
      puts key
<<<<<<< HEAD
      puts "lat: " + value["lat"]
      put "lon: " + value["lon"]
      puts "db: " + value["db"]
=======
      puts "lat: " + value['lat']
      put "lon: " + value['lon']
      puts "db: " + value['db']
>>>>>>> 1e80c3b97aa8643838142a7d6397c806efe9dfe7
      puts
      cs.coordinates.new(:lat => value["lat"], :lon => value["lon"], :db => value["db"])
    end
    cs.save
    respond_to do |format|
      format.json { render :json => params }
    end
  end
end
