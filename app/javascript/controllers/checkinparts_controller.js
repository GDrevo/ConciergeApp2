import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checkinparts"
export default class extends Controller {
  static targets = ["service", "container", "checkin", "checkout", "time", "price"]

  connect() {
    this.toggleHidden()
  }

  toggleHidden() {
    const checkinDiv = this.checkinTarget
    const checkoutDiv = this.checkoutTarget
    const container = this.containerTarget
    const selected = this.serviceTargets.find(function (target) {
      return target.checked
    })
    if (selected.value == "Check in") {
      if (checkinDiv.classList.contains("hidden")) {
        checkinDiv.classList.remove("hidden")
      }
      if (checkoutDiv.classList.contains("hidden") == false) {
        checkoutDiv.classList.add("hidden")
      }
      if (container.classList.contains("space-between")) {
        container.classList.remove("space-between")
      }
      if (container.classList.contains("flex-start") == false) {
        container.classList.add("flex-start")
      }
      if (container.classList.contains("flex-end")) {
        container.classList.remove("flex-end")
      }
      this.priceTarget.innerHTML = "25 €"
      this.timeTarget.innerHTML = "1 hour"
    }
    if (selected.value == "Check out") {
      if (checkinDiv.classList.contains("hidden") == false) {
        checkinDiv.classList.add("hidden")
      }
      if (checkoutDiv.classList.contains("hidden")) {
        checkoutDiv.classList.remove("hidden")
      }
      if (container.classList.contains("space-between")) {
        container.classList.remove("space-between")
      }
      if (container.classList.contains("flex-end") == false) {
        container.classList.add("flex-end")
      }
      if (container.classList.contains("flex-start")) {
        container.classList.remove("flex-start")
      }
      this.priceTarget.innerHTML = "25 €"
      this.timeTarget.innerHTML = "1 hour"
    }
    if (selected.value == "Check in & out") {
      if (checkinDiv.classList.contains("hidden")) {
        checkinDiv.classList.remove("hidden")
      }
      if (checkoutDiv.classList.contains("hidden")) {
        checkoutDiv.classList.remove("hidden")
      }
      if (container.classList.contains("space-between") == false) {
        container.classList.add("space-between")
      }
      if (container.classList.contains("flex-end")) {
        container.classList.remove("flex-end")
      }
      if (container.classList.contains("flex-start")) {
        container.classList.remove("flex-start")
      }
      this.priceTarget.innerHTML = "50 €"
      this.timeTarget.innerHTML = "2 hours"
    }
  }
}
