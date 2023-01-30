import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="time-and-price-estimations"
export default class extends Controller {
  static targets = ["rooms", "service", "duration", "price", "estimatedTime", "estimatedPrice"]

  connect() {
    const estimatedTime = this.roundHalf((this.roomsTime()) * this.serviceTime())
    this.durationTarget.innerHTML = estimatedTime + "hr(s)"
    this.estimatedTimeTarget.innerHTML = estimatedTime
    const price = (this.roomsPrice()) * this.servicePrice()
    this.priceTarget.innerHTML = price + "€"
    this.estimatedPriceTarget.innerHTML = price
  }

  updateTime() {
    const estimatedTime = this.roundHalf((this.roomsTime()) * this.serviceTime())
    this.durationTarget.innerHTML = estimatedTime + "hr(s)"
    this.estimatedTimeTarget.innerHTML = estimatedTime
    const price = (this.roomsPrice()) * this.servicePrice()
    this.priceTarget.innerHTML = price + "€"
    this.estimatedPriceTarget.innerHTML = price
  }

  roomsTime() {
    const selected = this.roomsTargets.find((target) => {
      return target.checked
    })
    return selected.value
  }

  roomsPrice() {
    const selected = this.roomsTargets.find((target) => {
      return target.checked
    })
    return selected.value
  }

  serviceTime() {
    const selected = this.serviceTargets.find((target) => {
      return target.checked
    })
    if (selected.value == "Basic") {
      return 1/3
    }
    if (selected.value == "Medium") {
      return 2/3
    }
    if (selected.value == "Premium") {
      return 4/3
    }
  }

  servicePrice() {
    const selected = this.serviceTargets.find((target) => {
      return target.checked
    })
    if (selected.value == "Basic") {
      return 20
    }
    if (selected.value == "Medium") {
      return 30
    }
    if (selected.value == "Premium") {
      return 40
    }
  }

  roundHalf(num) {
    return Math.round(num*2)/2
  }
}
