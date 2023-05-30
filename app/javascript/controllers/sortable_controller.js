import { Controller } from "@hotwired/stimulus";
import Sortable from "sortablejs";

export default class extends Controller {

  connect() {
    console.log(this.element)
    Sortable.create(this.element, {
      ghostClass: "ghost",
      animation: 150,
      group: "sortable",
      handle: ".handle",
      onEnd: (event) => {
        console.log(event)
        //alert(`${event.from} moved to ${event.to}`)
      }
    })
  }
}
