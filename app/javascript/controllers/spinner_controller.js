import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spinner"
export default class extends Controller {
  static targets = ["explore", "sBtn", "box", "input"]

  connect() {
    console.log("Connected to spinner controller!");
  }

  // insert() {
  //   // if you want it inside of the element
  //   this.element.innerHTML="<i class='fa-solid fa-spinner fa-spin'></i>"
  //   // if you want to replace the element
  //   // this.element.outerHTML=" <i class='fa-solid fa-cog fa-spin'></i>"
  // }

  insert() {
    const overlay = document.createElement("div");
    overlay.classList.add("loading-overlay");

    const spinner = document.createElement("i");
    spinner.classList.add("fa-solid", "fa-plane", "fa-fade", "fa-4x");
    spinner.style.position = "fixed";
    spinner.style.top = "50%";
    spinner.style.left = "50%";
    spinner.style.transform = "translate(-50%, -50%)";
    spinner.style.color = "#D6E4E5"

    // this.element.appendChild(spinner);
    overlay.appendChild(spinner);
    document.body.appendChild(overlay);
  }

  collapse() {
    console.log("COLLAPSE!");
    this.boxTarget.classList.toggle("active")
    this.sBtnTarget.classList.toggle("active")
    this.inputTarget.classList.toggle("active")
  }
}
