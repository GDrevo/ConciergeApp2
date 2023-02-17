import { Controller } from "@hotwired/stimulus";
import { DateTime } from "luxon";

// Connects to data-controller="end-date-calculation"
export default class extends Controller {
  static targets = ["startTime", "endTime", "duration", "checkinStartTime", "checkinEndTime"]

  updateEndTime() {
    const startTime = this.startTimeTarget.value
    const duration = this.durationTarget.innerText
    const durationregex = duration.match(/[^hr]+/)[0]
    const minutesToAdd = durationregex * 60
    const newYear = startTime.substring(0,4)
    const newMonth = startTime.substring(5,7)
    const newDay = startTime.substring(8,10)
    const newHour = startTime.substring(11,13)
    const newMin = startTime.substring(14,16)
    const endDate = DateTime.fromObject({year: newYear, month: newMonth, day: newDay, hour: newHour, minute: newMin})
    const newEndDate = endDate.plus({ minutes: minutesToAdd })
    const formattedNewEndDate = newEndDate.toFormat("y'-'LL'-'dd' 'HH':'mm")
    this.endTimeTarget.value = formattedNewEndDate
  }

  updateCheckinEndTime() {
    const startTime = this.checkinStartTimeTarget.value
    const duration = 1
    const minutesToAdd = duration * 60
    const newYear = startTime.substring(0,4)
    const newMonth = startTime.substring(5,7)
    const newDay = startTime.substring(8,10)
    const newHour = startTime.substring(11,13)
    const newMin = startTime.substring(14,16)
    const endDate = DateTime.fromObject({year: newYear, month: newMonth, day: newDay, hour: newHour, minute: newMin})
    const newEndDate = endDate.plus({ minutes: minutesToAdd })
    const formattedNewEndDate = newEndDate.toFormat("y'-'LL'-'dd' 'HH':'mm")
    this.checkinEndTimeTarget.value = formattedNewEndDate
  }
}
