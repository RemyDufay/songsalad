import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = [ "form", "list", "input", "count", "lyrics" ]

  send(event) {
    event.preventDefault();

    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
        this.listTarget.outerHTML  = data.list_html
        this.countTarget.outerHTML = data.count_html
        this.lyricsTarget.outerHTML = data.lyrics_html
        this.formTarget.reset()

        // this.formTarget.outerHTML = data.formHTML
      })
  }
}
