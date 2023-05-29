import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="active-tab"

export default class extends Controller {
  static targets = ["link"];

  connect() {
    // Get the current page URL
    const currentURL = window.location.pathname;

    // Find the link matching the current page URL
    const currentLink = this.linkTargets.find(link =>
      link.getAttribute("href") === currentURL
    );

    if (currentLink) {
      // Add active class to the current link
      currentLink.classList.add("active");
    }
  }

  setActiveTab(event) {
    // Remove active class from all links
    this.linkTargets.forEach(link => {
      link.classList.remove("active");
    });

    // Add active class to the clicked link
    event.currentTarget.classList.add("active");
  }
}
