
import SwiftUI

struct FlightStatusBoard: View {
  
  @State var flights: [FlightInformation]
  var filteredFlights: [FlightInformation] {
    hidePast ? self.flights.filter { $0.localTime >= Date() } : self.flights
  }
  var shortDateString: String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .none
    dateFormatter.dateFormat = "MMM d"
    return dateFormatter.string(from: Date())
  }
  @State private var hidePast = false
  @AppStorage("FlightStatusCurrentTab") var selectedTab = 1
  @State private var highlightedIds: [Int] = []
  
  func lastUpdateString(_ date: Date) -> String {
    let dateF = DateFormatter()
    dateF.timeStyle = .short
    dateF.dateFormat = .none
    return "Last updated: \(dateF.string(from: date))"
  }

  var body: some View {
    TimelineView(.everyMinute) { context in
      VStack {
        Text(lastUpdateString(context.date)).font(.footnote)
        TabView(selection: $selectedTab) {
          FlightList(flights: filteredFlights.filter{ $0.direction == .arrival},
                     highlightedIds: $highlightedIds)
            .tabItem {
              Image("descending-airplane").resizable()
              Text("Arrivals")
            }
            .badge(filteredFlights.filter{ $0.direction == .arrival}.count)
            .tag(0)
          FlightList(flights: filteredFlights,
                     highlightedIds: $highlightedIds)
            .tabItem {
              Image(systemName: "airplane").resizable()
              Text("All")
            }
            .badge(shortDateString)
            .tag(1)
          FlightList(flights: filteredFlights.filter { $0.direction == .departure },
                     highlightedIds: $highlightedIds)
            .tabItem {
              Image("ascending-airplane")
              Text("Departures")
            }
            .badge(filteredFlights.filter{ $0.direction == .departure}.count)
            .tag(2)
        }
        .refreshable(action: {
          await flights = FlightData.refreshFlights()
        })
        .navigationTitle("Flight Status")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          Toggle("Hide Past", isOn: $hidePast)
            .toggleStyle(.button)
      }
      }
    }
  }
}

struct FlightStatusBoard_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      FlightStatusBoard(flights: FlightData.generateTestFlights(date: Date()))
    }.navigationTitle("Flight Status")
  }
}


