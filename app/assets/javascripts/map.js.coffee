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
      mapTypeId: google.maps.MapTypeId.SATELLITE
  })


addHeatmapLayer = (json) ->
  for key,val of json
    console.log(val.db)
  heatMapData = ({location: new google.maps.LatLng(value.lat, value.lon), weight: value.db} for key, value of json)
  console.log(JSON.stringify heatMapData)
  if root.heatmap
    root.heatmap.setMap null

  root.heatmap = new google.maps.visualization.HeatmapLayer({
        data: heatMapData
  })
  root.heatmap.setMap(root.map)
  root.map.panTo(heatMapData[0].location)
