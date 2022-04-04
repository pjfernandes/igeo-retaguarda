import mapboxgl from '!mapbox-gl';

mapboxgl.accessToken = 'pk.eyJ1IjoicGpmZXJuYW5kZXMiLCJhIjoiY2t1c291Z3lzNWg2bzJvbW5kNWNhbnZhaCJ9.eYxvagOUGuS5qDo-zOfRCA';

let coordsArray = [];
coordsArray[0] = parseFloat(document.getElementById("point_longitude").value);
coordsArray[1] = parseFloat(document.getElementById("point_latitude").value);

var map = new mapboxgl.Map({
  container: 'map-new-point',
  style: "mapbox://styles/mapbox/satellite-v9",
  center: coordsArray,
  zoom: 9
});

var mapDiv = document.getElementById("map-new-point");
mapDiv.insertAdjacentHTML('beforeend', map);

var el = document.createElement('div');
el.id = 'marker';
var marker = new mapboxgl.Marker();
marker
  //.remove()
  .setLngLat(coordsArray)
  .addTo(map);

function add_marker(event) {
  marker.remove()
  var coordinates = event.lngLat;
  document.getElementById("point_longitude").value = coordinates.lng;
  document.getElementById("point_latitude").value = coordinates.lat;
  marker.remove().setLngLat(coordinates).addTo(map);
}

map.on('click', add_marker);

export { createCoords };
