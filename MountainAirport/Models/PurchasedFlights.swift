
import SwiftUI

class PurchasedFlights: ObservableObject {
  @Published var purchasedFlightIds: [Int] = []
  @AppStorage("PurchasedFlight") var purchasedFlightStorage = "" {
    didSet {
      purchasedFlightIds = getPurchasedFlights()
    }
  }

  init() {
    purchasedFlightIds = getPurchasedFlights()
  }

  init(flightId: Int) {
    purchasedFlightIds = [flightId]
  }

  init(flightIds: [Int]) {
    purchasedFlightIds = flightIds
  }

  func isFlightPurchased(_ flight: FlightInformation) -> Bool {
    let flightIds = purchasedFlightStorage.split(separator: ",").compactMap { Int($0) }
    let matching = flightIds.filter { $0 == flight.id }
    return matching.isEmpty == false
  }

  func purchaseFlight(_ flight: FlightInformation) {
    if !isFlightPurchased(flight) {
      print("Saving flight: \(flight.id)")
      var flights = purchasedFlightStorage.split(separator: ",").compactMap { Int($0) }
      flights.append(flight.id)
      purchasedFlightStorage = flights.map { String($0) }.joined(separator: ",")
    }  }

  func removePurchasedFlight(_ flight: FlightInformation) {
    if isFlightPurchased(flight) {
      print("Removing saved flight: \(flight.id)")
      let flights = purchasedFlightStorage.split(separator: ",").compactMap { Int($0) }
      let newFlights = flights.filter { $0 != flight.id }
      purchasedFlightStorage = newFlights.map { String($0) }.joined(separator: ",")
    }
  }

  func getPurchasedFlights() -> [Int] {
    let flightIds = purchasedFlightStorage.split(separator: ",").compactMap { Int($0) }
    return flightIds
  }
}
