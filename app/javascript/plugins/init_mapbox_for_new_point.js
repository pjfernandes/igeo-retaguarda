import mapboxgl from '!mapbox-gl';

function buildMapNewPoint() {
  mapboxgl.accessToken = 'pk.eyJ1IjoicGpmZXJuYW5kZXMiLCJhIjoiY2t1c291Z3lzNWg2bzJvbW5kNWNhbnZhaCJ9.eYxvagOUGuS5qDo-zOfRCA';

  var mapDiv = document.getElementById("map-new-point");

  let map = new mapboxgl.Map({
    container: 'map-new-point',
    style: "mapbox://styles/mapbox/satellite-v9",
    center: [-43, -22],
    zoom: 9
  });

  var el = document.createElement('div');
  el.id = 'marker';
  var marker = new mapboxgl.Marker();
  marker
    .setLngLat([-43, -22])
    .addTo(map);

  function add_marker(event) {
    marker.remove()
    var coordinates = event.lngLat;
    document.getElementById("point_longitude").value = coordinates.lng;
    document.getElementById("point_latitude").value = coordinates.lat;
    marker.remove().setLngLat(coordinates).addTo(map);
  }

  map.on('click', add_marker);

  return map;
}

export { buildMapNewPoint };
