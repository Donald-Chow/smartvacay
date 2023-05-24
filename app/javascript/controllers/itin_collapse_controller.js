import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="itin-collapse"
export default class extends Controller {
  static targets = ['date', 'list']

  connect() {

  }

  toggle() {
    this.dateTarget.classList.toggle("fa-chevron-right")
    this.listTarget.classList.toggle("d-none")

  }
}
