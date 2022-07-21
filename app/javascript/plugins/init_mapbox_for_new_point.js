import mapboxgl from '!mapbox-gl';

let coords;

if (document.querySelector(".map-edit-point")) {

  const latitude = parseFloat(document.querySelector("#point_latitude").value);
  const longitude = parseFloat(document.querySelector("#point_longitude").value);
  coords = [longitude, latitude];

} else {

  coords = [-43, -22];

}

console.log(coords);

const returnCoords = () => {
  var options = {
    enableHighAccuracy: true,
    timeout: 5000,
    maximumAge: 0
  };

  function success(pos) {
    coords = [pos.coords.longitude, pos.coords.latitude];
    //console.log(coords);
    //return coords;
  };

  function error(err) {
    let coords;
    if (document.querySelector(".map-edit-point")) {

      const latitude = parseFloat(document.querySelector("#point_latitude").value);
      const longitude = parseFloat(document.querySelector("#point_longitude").value);
      coords = [longitude, latitude];

    } else {

      coords = [-43, -22];

    }
    coords;
  };

  navigator.geolocation.getCurrentPosition(success, error, options);

};

returnCoords();

function buildMapNewPoint() {

  let coords;

  if (document.querySelector(".map-edit-point")) {

    const latitude = parseFloat(document.querySelector("#point_latitude").value);
    const longitude = parseFloat(document.querySelector("#point_longitude").value);
    coords = [longitude, latitude];

  } else {

    coords = [-43, -22];

  }
  mapboxgl.accessToken = 'pk.eyJ1IjoicGpmZXJuYW5kZXMiLCJhIjoiY2t1c291Z3lzNWg2bzJvbW5kNWNhbnZhaCJ9.eYxvagOUGuS5qDo-zOfRCA';

  if (document.getElementById("new_point") || document.getElementById("map-new-point")) {
    let map = new mapboxgl.Map({
      container: 'map-new-point',
      style: "mapbox://styles/mapbox/satellite-v9",
      center: coords,
      zoom: 8
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

export { buildMapNewPoint };
