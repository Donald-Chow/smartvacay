import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-bar"
export default class extends Controller {
  connect() {
    console.log(searchbox here!);
  }
}
