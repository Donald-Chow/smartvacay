import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="google-search"
export default class extends Controller {
  static targets = ["input"];

  connect() {
    console.log('Google Search Controller connected');
  }
  findPlaceFromQuery(e) {
    e.preventDefault();
    const query = this.inputTarget.value
    const map = new google.maps.Map(document.getElementById('map'), {
      zoom: 15
    });

    const service = new google.maps.places.PlacesService(map);
    const request = {
      query,
      fields: ["name", "geometry", "formatted_address", "rating", "formatted_address"]
    };

    service.findPlaceFromQuery(request, (results, status) => {
      if (status === google.maps.places.PlacesServiceStatus.OK) {
        console.log(results);
      }
    });
  }





}
