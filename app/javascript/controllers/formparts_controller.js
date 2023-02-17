import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="formparts"
export default class extends Controller {
  static targets = ["service", "checkinPart", "cleaningPart"]

  connect() {
    this.toggleHidden()
  }

  toggleHidden() {
    const checkinDiv = this.checkinPartTarget
    const cleaningDiv = this.cleaningPartTarget
    const selected = this.serviceTargets.find(function (target) {
      return target.checked
    })
    if (selected.value == "Check in/out") {
      // console.log(checkinDiv.classList.contains("hidden"))
      if (checkinDiv.classList.contains("hidden")) {
        checkinDiv.classList.remove("hidden")
      }
      if (cleaningDiv.classList.contains("hidden") == false) {
        cleaningDiv.classList.add("hidden")
      }
    }
    if (selected.value == "Cleaning") {
      if (checkinDiv.classList.contains("hidden") == false) {
        checkinDiv.classList.add("hidden")
      }
      if (cleaningDiv.classList.contains("hidden")) {
        cleaningDiv.classList.remove("hidden")
      }
    }
    if (selected.value == "Check in/out & Cleaning") {
      if (checkinDiv.classList.contains("hidden")) {
        checkinDiv.classList.remove("hidden")
      }
      if (cleaningDiv.classList.contains("hidden")) {
        cleaningDiv.classList.remove("hidden")
      }
    }
  }
}
