import { Controller } from "@hotwired/stimulus";
import Sortable from "sortablejs";

// Connects to data-controller="sortable-cards"
export default class extends Controller {
  static targets = ["itinerary"]
  static values = { Id: Number }
  connect() {
    Sortable.create(this.element, {
      ghostClass: "ghost",
      group: "sortable",
      handle: ".handle",
      animation: 150,
      onSort: (event) => {
        // Sends an AJAX request to update the spot_places for each spot
        // console.log(event.from.id)
        console.log(event.to.id)
        console.log(this.itineraryTargets.map((itin)=>itin.id))
        // this.updateTrip(Array.from(event.to.querySelectorAll(".card-itinerary")).map((itin)=> console.log(itin)))
        this.updateTrip(Array.from(event.to.querySelectorAll(".card-itinerary")).map((itin)=>`${event.to.id}|${itin.id}`))
        this.updateTrip(Array.from(event.from.querySelectorAll(".card-itinerary")).map((itin)=>`${event.from.id}|${itin.id}`))
        // this.updateTrip(this.itineraryTargets.map((itin)=>`${event.to.id}|${itin.id}`))
      },
    });
  }

  updateTrip(array) {

    const url = "/itineraries/update_all";
    console.log(url);
    console.log(JSON.stringify({array}))
    fetch(url, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({array}),
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(data);
        console.log(this.element);
        // console.log(this.element.HTML);
        this.element.innerHTML = data.day_list_html
      });
  }
}
