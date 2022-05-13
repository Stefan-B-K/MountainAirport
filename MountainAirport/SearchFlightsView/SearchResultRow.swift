
import SwiftUI

struct SearchResultRow: View {
  var flight: FlightInformation
  @State private var isPresented = false
  
  var timeFormatter: DateFormatter {
    let tdf = DateFormatter()
    tdf.timeStyle = .short
    tdf.dateStyle = .medium
    return tdf
  }
  
  var body: some View {
    Button {
      isPresented.toggle()
    } label: {
      FlightSearchSummary(flight: flight)
    }
    .sheet(isPresented: $isPresented) {
    } content: {
      FlightSearchDetails(flight: flight, showModal: $isPresented)
    }
  }
}

struct SearchResultRow_Previews: PreviewProvider {
  static var previews: some View {
    SearchResultRow(
      flight: FlightData.generateTestFlight(date: Date())
    )
  }
}
