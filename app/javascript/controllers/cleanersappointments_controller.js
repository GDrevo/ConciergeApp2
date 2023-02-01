import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cleanersappointments"
export default class extends Controller {
  static targets = ["cleanerList", "startDate", "endDate", "selectedCleaner"]

  updateCleaners(event) {
    event.preventDefault()

    const startDate = this.startDateTarget.value
    const endDate = this.endDateTarget.value
    const url = `/appointments/available_cleaners?start_date=${startDate}&end_date=${endDate}`
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
            this.cleanerListTarget.dispatchEvent(new Event("change"));
          })
        })
        .catch(error => console.log(error))
    }
  }

  updateSelectedCleaner(event) {
    const selectedCleanerId = event.target.value
    const url = `/cleaners/${selectedCleanerId}`
    console.log(url)
    fetch(url)
      .then(response => {
        if (!response.ok) {
          throw new Error(`Failed to fetch data: ${response.statusText}`);
        }
        console.log(response)
        return response.json();
      })
      .then(data => {
        console.log(data)
        this.selectedCleanerTarget.innerHTML = `<h3>${data.name}</h3> <p>This is the description of the cleaner called ${data.name}.</p>`
      })
      .catch(error => console.log(error))
  }
}
