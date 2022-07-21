import mapboxgl from '!mapbox-gl';

if (document.getElementById("map-edit-point")) {

  const latitude = document.querySelector("#point_latitude").value;
  const longitude = document.querySelector("#point_longitude").value;

  let coords = [latitude, longitude];

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
      coords = [-43, -22];
    };

    navigator.geolocation.getCurrentPosition(success, error, options);

  };

  //returnCoords();

  function editPoint() {
    mapboxgl.accessToken = 'pk.eyJ1IjoicGpmZXJuYW5kZXMiLCJhIjoiY2t1c291Z3lzNWg2bzJvbW5kNWNhbnZhaCJ9.eYxvagOUGuS5qDo-zOfRCA';

      let map = new mapboxgl.Map({
        container: 'map-edit-point',
        style: "mapbox://styles/mapbox/satellite-v9",
        center: coords,
        zoom: 10
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

} else {
  function editPoint() {
    console.log("OK");
  }
}

export { editPoint };
