import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-bar"
export default class extends Controller {
  static targets =["box", "sBtn", "cBtn", "input", "data"]

  connect() {
    console.log("search bar controller!!!");
  }

  collapse(event) {
    console.log("COLLAPSE!");
    this.boxTarget.classList.toggle("active")
    this.sBtnTarget.classList.toggle("active")
    // this.cBtnTarget.classList.toggle("active")
    this.inputTarget.classList.toggle("active")
    // this.inputTarget.classList.add("active")
  }

}
