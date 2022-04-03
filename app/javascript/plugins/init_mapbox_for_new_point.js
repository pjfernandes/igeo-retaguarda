import mapboxgl from '!mapbox-gl';

const buildMap = (mapElement) => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'map-new-point',
    style: "mapbox://styles/mapbox/satellite-v9",
    center: [-43, -22],
    zoom: 4
  });
};

// const addMarkersToMap = (map, markers) => {
//   markers.forEach((marker) => {
//     const popup = new mapboxgl.Popup().setHTML(marker.info_window); // add this

//     new mapboxgl.Marker()
//       .setLngLat([marker.lng, marker.lat])
//       .setPopup(popup) // add this
//       .addTo(map);
//   });
// };

// const fitMapToMarkers = (map, markers) => {
//   const bounds = new mapboxgl.LngLatBounds();
//   markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
//   map.fitBounds(bounds, { padding: 0, maxZoom: 10 });
// };

const initMapboxForNewPoint = () => {
  const mapElement = document.getElementById('map-new-point');
  if (mapElement) {
    const map = buildMap(mapElement);
    //const markers = JSON.parse(mapElement.dataset.markers);
    //addMarkersToMap(map, markers);
    //fitMapToMarkers(map, markers);
  }
};

export { initMapboxForNewPoint };
