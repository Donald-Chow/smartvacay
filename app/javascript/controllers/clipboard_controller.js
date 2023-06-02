import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input"];
  static values = {
    feedbackText: String,
    originalText: String
  }

  copy(event) {
    this.inputTarget.select();
    document.execCommand('copy');

    const button = event.currentTarget;
    if (button) {
      button.disabled = true;
      button.innerText = this.feedbackTextValue;

      setTimeout(() => {
        button.disabled = false;
        button.innerText = "Copy to Clipboard";
      }, 3000);
    }
  }

}
