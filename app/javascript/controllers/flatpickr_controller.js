import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";
// import rangePlugin from 'flatpickr/dist/plugins/rangePlugin';

export default class extends Controller {
  connect() {
    new flatpickr(this.element, {
      enableTime: false,
      minDate: "today",
      // allowInput: true,
      // more options available on the documentation!
    });
  }
}
