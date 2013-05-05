# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  initialise()

initialise = ->
  heatMapData = [
    {location: new google.maps.LatLng(37.782, -122.447), weight: 0.5},
    new google.maps.LatLng(37.782, -122.445),
    {location: new google.maps.LatLng(37.782, -122.443), weight: 2},
    {location: new google.maps.LatLng(37.782, -122.441), weight: 3},
    {location: new google.maps.LatLng(37.782, -122.439), weight: 2},
    new google.maps.LatLng(37.782, -122.437),
    {location: new google.maps.LatLng(37.782, -122.435), weight: 0.5},

    {location: new google.maps.LatLng(37.785, -122.447), weight: 3},
    {location: new google.maps.LatLng(37.785, -122.445), weight: 2},
    new google.maps.LatLng(37.785, -122.443),
    {location: new google.maps.LatLng(37.785, -122.441), weight: 0.5},
    new google.maps.LatLng(37.785, -122.439),
    {location: new google.maps.LatLng(37.785, -122.437), weight: 2},
    {location: new google.maps.LatLng(37.785, -122.435), weight: 3}
  ]

  sanFrancisco = new google.maps.LatLng(37.774546, -122.433523)

  map = new google.maps.Map($('#map-canvas')[0], {
      center: sanFrancisco,
      zoom: 13,
      mapTypeId: google.maps.MapTypeId.SATELLITE
  })

  heatmap = new google.maps.visualization.HeatmapLayer({
      data: heatMapData
  })

  heatmap.setMap(map)


initialize = ->
    myOptions =
      center: new google.maps.LatLng -34.397, 150.644
      zoom: 8,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    map = new google.maps.Map $('#map-canvas')[0], myOptions
