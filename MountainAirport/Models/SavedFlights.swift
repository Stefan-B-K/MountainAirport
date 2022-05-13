
import SwiftUI

class SavedFlights: ObservableObject {
  @Published var savedFlightIds: [Int] = []
  @AppStorage("SavedFlight") var savedFlightStorage = "" {
    didSet {
      savedFlightIds = getSavedFlights()
    }
  }

  init() {
    savedFlightIds = getSavedFlights()
  }

  init(flightId: Int) {
    savedFlightIds = [flightId]
  }

  init(flightIds: [Int]) {
    savedFlightIds = flightIds
  }

  func isFlightSaved(_ flight: FlightInformation) -> Bool {
    let flightIds = savedFlightStorage.split(separator: ",").compactMap { Int($0) }
    let matching = flightIds.filter { $0 == flight.id }
    return matching.isEmpty == false
  }

  func saveFight(_ flight: FlightInformation) {
    if !isFlightSaved(flight) {
      print("Saving flight: \(flight.id)")
      var flights = savedFlightStorage.split(separator: ",").compactMap { Int($0) }
      flights.append(flight.id)
      savedFlightStorage = flights.map { String($0) }.joined(separator: ",")
    }  }

  func removeSavedFlight(_ flight: FlightInformation) {
    if isFlightSaved(flight) {
      print("Removing saved flight: \(flight.id)")
      let flights = savedFlightStorage.split(separator: ",").compactMap { Int($0) }
      let newFlights = flights.filter { $0 != flight.id }
      savedFlightStorage = newFlights.map { String($0) }.joined(separator: ",")
    }
  }

  func getSavedFlights() -> [Int] {
    let flightIds = savedFlightStorage.split(separator: ",").compactMap { Int($0) }
    return flightIds
  }
}
