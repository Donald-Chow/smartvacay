import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-bar"
export default class extends Controller {
  static targets =["btn", "bar"]

  connect() {
    console.log("search bar controller!!!");
  }

  collapse(event) {
    console.log("COLLAPSE!");
    this.barTarget.classList.toggle("active")
    this.btnTarget.innerHTML="hello"
    // this.inputTarget.classList.add("active")
  }
}
