import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["content"]

  revealContent() {
    this.contentTarget.classList.toggle("max-height-5")
    this.contentTarget.classList.toggle("max-height-25")
  }
}
