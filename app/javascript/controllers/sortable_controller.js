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
      onAdd: this.swapCard.bind(this), onUpdate: this.swapCard.bind(this)
    });
  }

  async updateTrip(array, list) {

    const url = "/itineraries/update_all";
    // console.log(url);
    console.log(JSON.stringify({array}))
    const response = await fetch(url, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({array}),
    })
    const data = await response.json()
    console.log(data);
    // console.log(this.element);
    // console.log(this.element.HTML);
    list.innerHTML = data.day_list_html
    // if (callback) {callback()}
  }

    async swapCard(event) {
    // Sends an AJAX request to update the spot_places for each spot
    // console.log(event.from.id)
    // console.log(event.to.id)
    console.log(event);
    console.log(this);
    console.log(this.itineraryTargets.map((itin)=>itin.id))
    // this.updateTrip(Array.from(event.to.querySelectorAll(".card-itinerary")).map((itin)=> console.log(itin)))
    await this.updateTrip(Array.from(event.to.querySelectorAll(".card-itinerary")).map((itin)=>`${event.to.id}|${itin.id}`), event.to)
    await this.updateTrip(Array.from(event.from.querySelectorAll(".card-itinerary")).map((itin)=>`${event.from.id}|${itin.id}`), event.from)
    // this.updateTrip(this.itineraryTargets.map((itin)=>`${event.to.id}|${itin.id}`))
  }
}
