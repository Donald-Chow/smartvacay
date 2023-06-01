import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";
import rangePlugin from 'flatpickr/dist/plugins/rangePlugin';

export default class extends Controller {
  static targets = ["startTime", "endTime" ]
  connect() {
    flatpickr(this.startTimeTarget, {
      enableTime: false,
      minDate: "today",
      altInput: true,
      mode: "range",
      plugins: [new rangePlugin({ input: "#end_time"})]
      // allowInput: true,
      // more options available on the documentation!
    });
    flatpickr(this.endTimeTarget, {})
  }
}
