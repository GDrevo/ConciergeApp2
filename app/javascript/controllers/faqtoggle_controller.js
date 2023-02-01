import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="faqtoggle"
export default class extends Controller {
  static targets = ["answer"]

  toggle() {
    this.answerTarget.classList.toggle("hidden")
  }
}
