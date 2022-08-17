import mapboxgl from '!mapbox-gl';

function buildMapNewPoint2() {
  if (document.querySelector(".map-edit-point")) {
    var coords;

    if (document.querySelector(".map-edit-point")) {

      const latitude = parseFloat(document.querySelector("#point_latitude").value);
      const longitude = parseFloat(document.querySelector("#point_longitude").value);
      coords = [longitude, latitude];

    } else {


    //   //const long = parseFloat(document.getElementById("occurrence_longitude").value);
    //   //const lat = parseFloat(document.getElementById("occurrence_latitude").value);

    coords = [-43, -22];

    //   console.log(coords);
    }

    mapboxgl.accessToken = 'pk.eyJ1IjoicGpmZXJuYW5kZXMiLCJhIjoiY2t1c291Z3lzNWg2bzJvbW5kNWNhbnZhaCJ9.eYxvagOUGuS5qDo-zOfRCA';

    if (document.getElementById("new_point") || document.getElementById("map-edit-point")) {
      let map = new mapboxgl.Map({
        container: 'map-edit-point',
        style: "mapbox://styles/mapbox/satellite-v9",
        center: coords,
        zoom: 6
      });

      var el = document.createElement('div');
      el.id = 'marker';

      var marker = new mapboxgl.Marker();
      marker
        .setLngLat(coords)
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
  }
}

export { buildMapNewPoint2 };
