import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="category-search"
export default class extends Controller {
  static targets = ["avatar", "list"]
  static values = {
    baseurl: String
  }

  connect() {
    console.log("Connected to category-search controller");
    // console.log(this.element);
    // console.log(this.avatarTargets);
    // console.log(this.listTargets);
    // console.log(this.baseurlValue);
  }

  showLists (event) {
    console.log("TO DO FILTER THE LISTS");
    // event.preventDefault();
    const category = event.currentTarget.dataset.category
    // How to adjust url to fit to Heroku or other domains?
    // console.log(event.currentTarget.dataset.action)
    const baseurl = this.baseurlValue;
    const url = `${baseurl}/locations/my_favorites?category=${category}`
    fetch(url, {
      headers: { "Accept": "text/plain" }
    })
    // console.log(url)
      .then(response => response.text())
      .then(data => {
        // Update the list with the filtered list
        const listTarget = this.listTarget;
        listTarget.innerHTML = data;
      })

    this.avatarTargets.forEach((avatar) => {
      event.preventDefault();
      avatar.classList.remove("active");
      if (avatar === event.currentTarget) {
        avatar.classList.add("active");
      }
    })
  }
}
