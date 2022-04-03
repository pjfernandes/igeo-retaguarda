const createCoords = () => {

  if (document.querySelector(".simple_form")) {
    var options = {
      enableHighAccuracy: true,
      timeout: 5000,
      maximumAge: 0
    };

    var coords;
    function success(pos) {
      coords = [pos.coords.longitude, pos.coords.latitude];

      //const position = document.getElementById('position');
      //position.insertAdjacentHTML('beforeend', `<p>${coords[1].toFixed(3)}°, ${coords[0].toFixed(3)}°</p>`);

      //const teste = document.querySelector(".simple_form");

      // teste.insertAdjacentHTML('beforeend', `<div class="form-group float optional occurrence_latitude">

      //                                               <input class="form-control numeric float optional" placeholder="Latitude"
      //                                               type="hidden" step="any" name="occurrence[latitude]"
      //                                               id="occurrence_latitude" value=${coords[0]} readonly="readonly" >
      //                                             </div>`);



      // teste.insertAdjacentHTML('beforeend', `<div class="form-group float optional occurrence_longitude">

      //                                                 <input class="form-control numeric float optional" placeholder="Longitude"
      //                                                 type="hidden" step="any" name="occurrence[longitude]"
      //                                                 id="occurrence_longitude" value=${coords[1]} readonly="readonly">
      //                                               </div>`);
      document.getElementById("point_latitude").value = coords[1];
      document.getElementById("point_longitude").value = coords[0];
      console.log(coords);

      mapboxgl.accessToken = 'pk.eyJ1IjoicGpmZXJuYW5kZXMiLCJhIjoiY2t1c291Z3lzNWg2bzJvbW5kNWNhbnZhaCJ9.eYxvagOUGuS5qDo-zOfRCA';

      var map = new mapboxgl.Map({
        container: 'map-new-point',
        style: "mapbox://styles/mapbox/satellite-v9",
        center: coords,
        zoom: 9
      });

      var marker = new mapboxgl.Marker();
      //var popup = new mapboxgl.Popup({ offset: 25 }).setText(`${element[0]} ${element[1]}, ${element[2]}`);
      var el = document.createElement('div');
      el.id = 'marker';
      marker
        //.remove()
        .setLngLat(coords)//.setPopup(popup)
        .addTo(map);


    };

    function error(err) {
      console.warn('ERROR(' + err.code + '): ' + err.message);
    };
    navigator.geolocation.getCurrentPosition(success, error, options);
  }
};

export { createCoords };
