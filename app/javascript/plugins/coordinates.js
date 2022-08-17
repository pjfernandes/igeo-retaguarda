// const createCoords = () => {
//   if (document.getElementById("new_point")) {
//     var options = {
//       enableHighAccuracy: true,
//       timeout: 5000,
//       maximumAge: 0
//     };

//     var coords;
//     function success(pos) {
//       coords = [pos.coords.longitude, pos.coords.latitude];
//       document.getElementById("point_latitude").value = coords[1];
//       document.getElementById("point_longitude").value = coords[0];
//       //console.log(coords);
//     };

//     function error(err) {
//       console.warn('ERROR(' + err.code + '): ' + err.message);
//     };
//     navigator.geolocation.getCurrentPosition(success, error, options);
//   }
// };

// export { createCoords };
const createCoords = () => {

  if (document.getElementById('new-form')) {
    var options = {
      enableHighAccuracy: true,
      timeout: 5000,
      maximumAge: 0
    };


    var coords;
    function success(pos) {
      coords = [pos.coords.latitude, pos.coords.longitude];

      const teste = document.getElementById('new-form');

      teste.insertAdjacentHTML('beforeend', `<div class="form-group float optional occurrence_latitude">

                                                    <input class="form-control numeric float optional" placeholder="Latitude"
                                                    type="hidden" step="any" name="occurrence[latitude]"
                                                    id="occurrence_latitude" value=${coords[0]} readonly="readonly" >
                                                  </div>`);



      teste.insertAdjacentHTML('beforeend', `<div class="form-group float optional occurrence_longitude">

                                                      <input class="form-control numeric float optional" placeholder="Longitude"
                                                      type="hidden" step="any" name="occurrence[longitude]"
                                                      id="occurrence_longitude" value=${coords[1]} readonly="readonly">
                                                    </div>`);

      console.log(coords);
    };

    function error(err) {
      console.warn('ERROR(' + err.code + '): ' + err.message);
    };

    navigator.geolocation.getCurrentPosition(success, error, options);


  }
};

export { createCoords };
