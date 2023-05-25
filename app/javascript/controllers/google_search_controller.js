// Import the necessary modules
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="google-search"
export default class extends Controller {
  static targets = ["input", "list"];

  connect() {
    console.log('Google Search Controller connected');
  }

  search(event) {
    event.preventDefault();
    console.log("SEARCHING!");
    console.log(this.element);
    console.log(this.inputTarget);

    fetch(this.inputTarget.action, {
      method: "GET",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
      })
  }

  findPlaceFromQuery(event) {
    event.preventDefault();


    const query = this.inputTarget.value
    const map = new google.maps.Map(document.getElementById('map'), {
      zoom: 15
    });

    const service = new google.maps.places.PlacesService(map);
    const request = {
      locationBias: '10000', // Cordinates defining the area to search, can use location
      query,
      fields: ["name", "geometry", "formatted_address", "rating", "photos", "types", "place_id"]
    };

    service.textSearch(request, (results, status) => {
      if (status === google.maps.places.PlacesServiceStatus.OK) {
        console.log(results); //console log is just to display in console
        const cardContainer = document.getElementById('card-container');
        cardContainer.innerHTML = '';
        for (var i = 0; i < results.length; i++) {

          // Creating the card element
          const card = document.createElement('div');
          card.classList.add('card');

          // Seting  card content
          const name = document.createElement('h3');
          name.textContent = results[i].name;
          card.appendChild(name);

          const address = document.createElement('p');
          address.textContent = results[i].formatted_address;
          card.appendChild(address);

          const rating = document.createElement('p');
          rating.textContent = `Rating: ${results[i].rating}`;
          card.appendChild(rating);

          const place_id = document.createElement('p');
          rating.textContent = `place_id: ${results[i].place_id}`;
          card.appendChild(place_id);

          if (results[i].photos) {
            const photo = document.createElement('img');
            const photoUrl = results[i].photos[0].getUrl({ maxWidth: 500, maxHeight: 333 });
            photo.src = photoUrl;
            card.appendChild(photo);
          }

          // I am taking just the first type to now overwhelm with info
          const types = document.createElement('p');
          types.textContent = `Type: ${results[i].types[0]}`;
          card.appendChild(types);

          // The review is not working
          // const review = document.createElement('p');
          // review.textContent = `Type: ${results[0].reviews}`;
          // card.appendChild(review);



          // Update the card container with the new card


          cardContainer.appendChild(card);
        }
      }
    });
  }
}
