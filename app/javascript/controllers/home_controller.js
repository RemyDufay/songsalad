import { Controller } from "stimulus"
import Rails from "@rails/ujs";



export default class extends Controller {
  static targets = [ "home" ]

  out(event) {
    event.preventDefault();
    this.homeTarget.classList.add("animate__animated", "animate__backOutLeft");
    var path = event.target.action;
    setTimeout(function(){
      Rails.ajax({url: path, type: 'POST'});
    }, 500);
  }

}
