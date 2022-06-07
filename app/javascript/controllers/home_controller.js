import { Controller } from "stimulus"
import Rails from "@rails/ujs";



export default class extends Controller {
  static targets = [ "home" ]

  out(event) {
    event.preventDefault();
    console.log("stop !")
    var self = this;
    this.homeTarget.classList.add("animate__animated", "animate__backOutRight")
    setTimeout(gotosession, 450)
  }

}


function gotosession() {
  Rails.ajax({url: '/games/3/game_sessions',type: 'POST'});
}
