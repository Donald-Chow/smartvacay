// import { Controller } from "@hotwired/stimulus";
// import Sortable from "sortablejs";

// export default class extends Controller {

//   connect() {
//     console.log(this.element)
//     Sortable.create(this.element, {
//       ghostClass: "ghost",
//       animation: 150,
//       group: "sortable",
//       handle: ".handle",
//       onEnd: (event) => {
//         console.log(event)
//         //alert(`${event.from} moved to ${event.to}`)

//       }
//     })
//   }
// }


import { Controller } from "@hotwired/stimulus";
import Sortable from "sortablejs";

// Connects to data-controller="sortable-cards"
export default class extends Controller {
  static targets = ["spot"]
  static values = { Id: Number }
  connect() {
    Sortable.create(this.element, {
      ghostClass: "ghost",
      group: "sortable",
      handle: ".handle",
      animation: 150,
      onEnd: (event) => {
        // Sends an AJAX request to update the spot_places for each spot
        const toParent = event.to.dataset
        console.log(event.to)
        const toId = toParent.querySelector(".card-itinerary-box").id
        console.log(toId);
        const fromParent = event.from
        const fromId = fromParent.querySelector(".card-itinerary-box").id
        console.log(fromId);
        // if (toId !== fromId) {
        //   // this.updateTrip(event.to);
        //   console.log("hihihihi");
        //   this.updateTrip(toId, fromId);
        // }
        // console.log(event);
      },
    });
  }

  updateTrip(rowElement1, rowElement2) {

    const url = window.location.pathname+ "/itineraries/update_all";
    console.log(url);
    fetch(url, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ to: toID, from: fromId }),
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(data);
      });
  }
}
