
import SwiftUI

struct FlightList: View {
  var flights: [FlightInformation]
  
  var nextFlightId: Int {
    guard let flight = flights.first(where: { $0.localTime >= Date() })
    else { return flights.last!.id }
    return flight.id
  }
  
  @Binding var highlightedIds: [Int]
  
  func rowHighlighted(_ flightId: Int) -> Bool {
    highlightedIds.contains(flightId)
  }
  
  var body: some View {
    ScrollViewReader { scrollProxy in
      List(flights) { flight in
        NavigationLink {
          FlightDetails(flight: flight)
        } label: {
          FlightRow(flight: flight)
        }
        .listRowBackground(rowHighlighted(flight.id) ? Color.yellow.opacity(0.6) : Color.clear)
        .swipeActions(edge: .leading) {
          HighlightActionView(flightId: flight.id, highlightedIds: $highlightedIds)
        }
      }
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
          withAnimation {
            scrollProxy.scrollTo(nextFlightId, anchor: .top)
          }
        }
      }
    }
  }
}

struct FlightList_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      FlightList(
        flights: FlightData.generateTestFlights(date: Date()),
        highlightedIds: .constant([1, 2, 4])
      )
    }
  }
}
