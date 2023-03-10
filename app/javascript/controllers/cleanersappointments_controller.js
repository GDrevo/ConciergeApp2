import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cleanersappointments"
export default class extends Controller {
  static targets = ["cleanerList", "startDate", "endDate", "selectedCleaner", "checkinCleanerList", "checkinStartDate", "checkinEndDate", "selectedCheckinCleaner", "checkoutCleanerList", "checkoutStartDate", "checkoutEndDate", "selectedCheckoutCleaner"]

  updateCleaners(event) {
    event.preventDefault()

    const startDate = this.startDateTarget.value
    const endDate = this.endDateTarget.value
    const url = `/appointments/available_cleaners?start_date=${startDate}&end_date=${endDate}`
    if (startDate !== "" && endDate !== "") {
      fetch(url)
        .then(response => response.json())
        .then(data => {
          const indices = []
          while (indices.length < 5) {
            const randomIndex = Math.floor(Math.random() * data.length)
            if (!indices.includes(randomIndex)) {
              indices.push(randomIndex)
            }
          }
          const shuffledCleaners = indices.map(index => data[index])
          this.cleanerListTarget.innerHTML = ""
          shuffledCleaners.forEach(cleaner => {
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
    fetch(url)
      .then(response => {
        if (!response.ok) {
          throw new Error(`Failed to fetch data: ${response.statusText}`);
        }
        return response.json();
      })
      .then(data => {
        this.selectedCleanerTarget.innerHTML = `<h4>${data.name}</h4> <p>${data.description}</p>`
      })
      .catch(error => console.log(error))
  }

  updateCheckinCleaners(event) {
    event.preventDefault()

    const startDate = this.checkinStartDateTarget.value
    const endDate = this.checkinEndDateTarget.value
    const url = `/appointments/available_cleaners?start_date=${startDate}&end_date=${endDate}`
    if (startDate !== "" && endDate !== "") {
      fetch(url)
        .then(response => response.json())
        .then(data => {
          const indices = []
          while (indices.length < 5) {
            const randomIndex = Math.floor(Math.random() * data.length)
            if (!indices.includes(randomIndex)) {
              indices.push(randomIndex)
            }
          }
          const shuffledCleaners = indices.map(index => data[index])
          this.checkinCleanerListTarget.innerHTML = ""
          shuffledCleaners.forEach(cleaner => {
            const option = document.createElement("option")
            option.value = cleaner.id
            option.text = cleaner.name
            this.checkinCleanerListTarget.appendChild(option)
            this.checkinCleanerListTarget.dispatchEvent(new Event("change"));
          })
        })
        .catch(error => console.log(error))
    }
  }

  updateSelectedCheckinCleaner(event) {
    const selectedCleanerId = event.target.value
    const url = `/cleaners/${selectedCleanerId}`
    fetch(url)
      .then(response => {
        if (!response.ok) {
          throw new Error(`Failed to fetch data: ${response.statusText}`);
        }
        return response.json();
      })
      .catch(error => console.log(error))
  }

  updateCheckoutCleaners(event) {
    event.preventDefault()

    const startDate = this.checkoutStartDateTarget.value
    const endDate = this.checkoutEndDateTarget.value
    const url = `/appointments/available_cleaners?start_date=${startDate}&end_date=${endDate}`
    if (startDate !== "" && endDate !== "") {
      fetch(url)
        .then(response => response.json())
        .then(data => {
          const indices = []
          while (indices.length < 5) {
            const randomIndex = Math.floor(Math.random() * data.length)
            if (!indices.includes(randomIndex)) {
              indices.push(randomIndex)
            }
          }
          const shuffledCleaners = indices.map(index => data[index])
          this.checkoutCleanerListTarget.innerHTML = ""
          shuffledCleaners.forEach(cleaner => {
            const option = document.createElement("option")
            option.value = cleaner.id
            option.text = cleaner.name
            this.checkoutCleanerListTarget.appendChild(option)
            this.checkoutCleanerListTarget.dispatchEvent(new Event("change"));
          })
        })
        .catch(error => console.log(error))
    }
  }

  updateSelectedCheckoutCleaner(event) {
    const selectedCleanerId = event.target.value
    const url = `/cleaners/${selectedCleanerId}`
    fetch(url)
      .then(response => {
        if (!response.ok) {
          throw new Error(`Failed to fetch data: ${response.statusText}`);
        }
        return response.json();
      })
      .catch(error => console.log(error))
  }
}
