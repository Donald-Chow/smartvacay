// Import the necessary modules
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

        // Create the card element
        const card = document.createElement('div');
        card.classList.add('card');

        // Set the card content
        const name = document.createElement('h3');
        name.textContent = results[0].name;
        card.appendChild(name);

        const address = document.createElement('p');
        address.textContent = results[0].formatted_address;
        card.appendChild(address);

        // Update the card container with the new card
        const cardContainer = document.getElementById('card-container');
        cardContainer.innerHTML = '';
        cardContainer.appendChild(card);
      }
    });
  }
}
