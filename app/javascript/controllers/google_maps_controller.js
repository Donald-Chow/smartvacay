import { Controller } from "@hotwired/stimulus"
// Don't forget to import GMaps!
import GMaps from 'gmaps';

// Connects to data-controller="google-maps"
export default class extends Controller {
  connect() {
    const map = new GMaps({ el: '#map', lat: 0, lng: 0 });
    const markers = JSON.parse(this.element.dataset.markers);
    map.addMarkers(markers);
    if (markers.length === 0) {
      map.setZoom(2);
    } else if (markers.length === 1) {
      map.setCenter(markers[0].lat, markers[0].lng);
      map.setZoom(14);
    } else {
      map.fitLatLngBounds(markers);
    }
    console.log(map);
    console.log(markers);
  }

  findPlaceFromQuery(e) {
    e.preventDefault();
    console.log('submit');
    const service = new google.maps.places.PlacesService(map);
    const request = {
      query: "tokyo",
      fields: ["name", "geometry"],
    };

    service.findPlaceFromQuery(request, (results, status) => {
      if (status === google.maps.places.PlacesServiceStatus.OK) {
        console.log(results);
      }
    });
  }

}
