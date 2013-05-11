# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

root = exports ? this


$ ->
  initialise()


initialise = ->
  $('select').on('change', ->
    # ajax call with select's value
    $.ajax({
      url: "data/" + this.value,
      success: (json) ->
        addHeatmapLayer(json)
    })
  )
  
  sanFrancisco = new google.maps.LatLng(37.774546, -122.433523)

  root.map = new google.maps.Map($('#map-canvas')[0], {
      center: sanFrancisco,
      zoom: 13,
      mapTypeId: google.maps.MapTypeId.SATELLITE,
      scaleControl: true
  })

  root.heatmap = new HeatmapOverlay(root.map, {"radius": 10, "visible": true, "opacity": 60, legend: {position: "br", title: "Approximate dB Difference (Not absolute values)"}})



addHeatmapLayer = (json) ->
  data = ({lat: value.lat, lng: value.lon, count: value.db} for key, value of json)
  console.log(data)
  root.heatmap.setDataSet ({max: 200, data: data})
  root.map.panTo (new google.maps.LatLng(data[0].lat, data[0].lng))

#Mercator --BEGIN--

TILE_SIZE = 256
bound = (value, opt_min, opt_max) ->
  value = Math.max(value, opt_min)  if opt_min isnt null
  value = Math.min(value, opt_max)  if opt_max isnt null
  value
degreesToRadians = (deg) ->
  deg * (Math.PI / 180)
radiansToDegrees = (rad) ->
  rad / (Math.PI / 180)
MercatorProjection = ->
  @pixelOrigin_ = new google.maps.Point(TILE_SIZE / 2, TILE_SIZE / 2)
  @pixelsPerLonDegree_ = TILE_SIZE / 360
  @pixelsPerLonRadian_ = TILE_SIZE / (2 * Math.PI)

MercatorProjection::fromLatLngToPoint = (latLng, opt_point) ->
  me = this
  point = opt_point or new google.maps.Point(0, 0)
  origin = me.pixelOrigin_
  point.x = origin.x + latLng.lng() * me.pixelsPerLonDegree_
  
  # NOTE(appleton): Truncating to 0.9999 effectively limits latitude to
  # 89.189.  This is about a third of a tile past the edge of the world
  # tile.
  siny = bound(Math.sin(degreesToRadians(latLng.lat())), -0.9999, 0.9999)
  point.y = origin.y + 0.5 * Math.log((1 + siny) / (1 - siny)) * -me.pixelsPerLonRadian_
  point

MercatorProjection::fromPointToLatLng = (point) ->
  me = this
  origin = me.pixelOrigin_
  lng = (point.x - origin.x) / me.pixelsPerLonDegree_
  latRadians = (point.y - origin.y) / -me.pixelsPerLonRadian_
  lat = radiansToDegrees(2 * Math.atan(Math.exp(latRadians)) - Math.PI / 2)
  new google.maps.LatLng(lat, lng)

#Mercator --END--


getNewRadius = (desiredRadiusPerPointInMeters) ->
  numTiles = 1 << root.map.getZoom()
  center = root.map.getCenter()
  moved = google.maps.geometry.spherical.computeOffset(center, 10000, 90)
  projection = new MercatorProjection()
  initCoord = projection.fromLatLngToPoint(center)
  endCoord = projection.fromLatLngToPoint(moved)
  initPoint = new google.maps.Point(
    initCoord.x * numTiles,
    initCoord.y * numTiles)
  endPoint = new google.maps.Point(
    endCoord.x * numTiles,
    endCoord.y * numTiles)
  pixelsPerMeter = (Math.abs(initPoint.x-endPoint.x))/10000.0
  totalPixelSize = Math.floor(desiredRadiusPerPointInMeters*pixelsPerMeter)
