
import SwiftUI

struct FlightSearchSummary: View {
  var flight: FlightInformation

  var timeFormatter: DateFormatter {
    let tdf = DateFormatter()
    tdf.timeStyle = .short
    tdf.dateStyle = .medium
    return tdf
  }

  var body: some View {
    HStack {
      FlightStatusIcon(flight: flight)
        .padding(5)
        .clipShape(RoundedRectangle(cornerRadius: 7.0))
      VStack(alignment: .leading) {
        Text(flight.flightName)
          .font(.title3) +
          Text(" \(flight.dirString) \(flight.otherAirport)")
        HStack {
          Text(flight.localTime, formatter: timeFormatter)
            .foregroundColor(.gray)
        }
      }
    }
  }
}

struct FlightSearchSummary_Previews: PreviewProvider {
  static var previews: some View {
    FlightSearchSummary(
      flight: FlightData.generateTestFlight(date: Date())
    )
  }
}
