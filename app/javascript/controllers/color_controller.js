// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"



export default class extends Controller {
  static targets = [ "guessed" ]

  connect() {
    var hash = (document.URL.split('#').length > 1) ? document.URL.split('#')[1] : null;
    var hash = decodeURIComponent(hash)

    this.guessedTargets.forEach( (elem) => {
      if (elem.textContent.toLowerCase() != hash) {
      elem.classList.remove("animate__animated")
      elem.classList.remove("animate__swing")
      elem.classList.remove("new")
      elem.classList.add("old")
      }
    } )

  }
}
