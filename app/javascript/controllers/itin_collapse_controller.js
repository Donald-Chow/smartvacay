import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="itin-collapse"
export default class extends Controller {
  static targets = ['date', 'list', 'bookmark']

  connect() {

  }

  toggle() {
    this.dateTarget.classList.toggle("fa-chevron-right")
    this.listTarget.classList.toggle("d-none")

  }

  toggle_bookmark() {
    if (this.bookmarkTarget.classList.contains("fa-solid")) {
      this.bookmarkTarget.classList.replace("fa-solid", "fa-regular");
      //this.bookmarkTarget.innerHTML = "Bookmarked <i class='fa-solid fa-bookmark'></i>"
      //this.bookmarkTarget.innerText = "Bookmarked"

    } else {
      this.bookmarkTarget.classList.replace("fa-regular", "fa-solid");
      //this.bookmarkTarget.innerHTML = "Bookmark it! <i class='fa-regular fa-bookmark'></i>"
    }
  }
}
