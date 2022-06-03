import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["input"];
  static values = {
    feedbackText: String,
    copied: String
  }

  copy(event) {

    navigator.clipboard.writeText(this.copiedValue);
    event.currentTarget.disabled = true;
    event.currentTarget.innerText = this.feedbackTextValue;
  }
}
