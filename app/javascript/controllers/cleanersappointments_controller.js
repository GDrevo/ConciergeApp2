import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cleanersappointments"
export default class extends Controller {
  static targets = ["cleanerList", "startDate", "endDate"]

  updateCleaners(event) {
    event.preventDefault()

    const startDate = this.startDateTarget.value
    const endDate = this.endDateTarget.value
    const url = `/appointments/available_cleaners?start_date=${startDate}&end_date=${endDate}`
    console.log(url)
    if (startDate !== "" && endDate !== "") {
      fetch(url)
        .then(response => response.json())
        .then(data => {
          this.cleanerListTarget.innerHTML = ""
          data.forEach(cleaner => {
            const option = document.createElement("option")
            option.value = cleaner.id
            option.text = cleaner.name
            this.cleanerListTarget.appendChild(option)
          })
        })
        .catch(error => console.log(error))
    }
  }
}
