
import SwiftUI

struct GenericTimeline<Content, T>: View where Content: View, T: Identifiable {
  let events: [T]
  let content: (T) -> Content
  let timeProperty: KeyPath<T, Date>
  
  
  init(
    events: [T],
    timeProperty: KeyPath<T, Date>,
    @ViewBuilder content: @escaping (T) -> Content
  ) {
    self.events = events
    self.timeProperty = timeProperty
    self.content = content
  }
  
  var earliestHour: Int {
    let flightsAscending = events.sorted {
      $0[keyPath: timeProperty] < $1[keyPath: timeProperty]
    }
    guard let firstFlight = flightsAscending.first else { return 0 }
    let hour = Calendar.current.component(.hour, from: firstFlight[keyPath: timeProperty])
    return hour
  }

  var latestHour: Int {
    let flightsAscending = events.sorted {
      $0[keyPath: timeProperty] > $1[keyPath: timeProperty]
    }

    guard let firstFlight = flightsAscending.first else { return 24 }
    let hour = Calendar.current.component(.hour, from: firstFlight[keyPath: timeProperty])
    return hour + 1
  }

  func eventsInHour(_ hour: Int) -> [T] {
    return events
      .filter {
        let flightHour = Calendar.current.component(.hour, from: $0[keyPath: timeProperty])
        return flightHour == hour
      }
  }

  func hourString(_ hour: Int) -> String {
    let tcmp = DateComponents(hour: hour)
    if let time = Calendar.current.date(from: tcmp) {
      return shortTimeFormatter.string(from: time)
    }
    return "Unknown"
  }

  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        ForEach(earliestHour..<latestHour, id: \.self) { hour in
          let hourFlights = eventsInHour(hour)
          Text(hourString(hour))
            .font(.title2)
          ForEach(hourFlights.indices, id: \.self) { index in
            content(hourFlights[index])
          }
        }
      }
    }

  }
}

struct GenericTimeline_Previews: PreviewProvider {
  static var previews: some View {
    GenericTimeline(
      events: FlightData.generateTestFlights(date: Date()), timeProperty: \.localTime
    ) { flight in
      FlightCardView(flight: flight)
    }
  }
}
