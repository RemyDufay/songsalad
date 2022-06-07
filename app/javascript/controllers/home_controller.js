import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "home" ]

  out() {
    this.homeTarget.classList.add("animate__animated", "animate__fadeOutRight")
  }
}
