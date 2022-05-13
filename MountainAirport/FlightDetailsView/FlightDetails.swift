
import SwiftUI

struct FlightDetails: View {
  var flight: FlightInformation
  @EnvironmentObject var lastFlight: AppEnvironment
  
  var body: some View {
    ZStack {
      Image("background-view")
        .resizable()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      VStack(alignment: .leading) {
        FlightDetailHeader(flight: flight)
        FlightInfoPanel(flight: flight)
          .padding()
          .background(RoundedRectangle(cornerRadius: 20.0)
              .opacity(0.3))
        Spacer()
      }.foregroundColor(.white)
      .padding()
      .navigationTitle("")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        Text("\(flight.airline) Flight \(flight.number)")
      }
    }
    .onAppear {
      lastFlight.lastFlightId = flight.id
    }
  }
}

struct FlightDetails_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      FlightDetails(
        flight: FlightData.generateTestFlight(date: Date())
      )
      .environmentObject(AppEnvironment())
    }
  }
}
