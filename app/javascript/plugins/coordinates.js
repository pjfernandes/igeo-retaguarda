const createCoords = () => {
  if (document.getElementById("new_point")) {
    var options = {
      enableHighAccuracy: true,
      timeout: 5000,
      maximumAge: 0
    };

    var coords;
    function success(pos) {
      coords = [pos.coords.longitude, pos.coords.latitude];
      document.getElementById("point_latitude").value = coords[1];
      document.getElementById("point_longitude").value = coords[0];
      //console.log(coords);
    };

    function error(err) {
      console.warn('ERROR(' + err.code + '): ' + err.message);
    };
    navigator.geolocation.getCurrentPosition(success, error, options);
  }
};

export { createCoords };
