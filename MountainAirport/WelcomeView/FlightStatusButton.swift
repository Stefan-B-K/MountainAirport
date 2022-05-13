
import SwiftUI

struct FlightStatusButton: View {
  @ObservedObject var flightInfo: FlightData

  var body: some View {
    NavigationLink(
      destination: FlightStatusBoard(
        flights: flightInfo.getDaysFlights(Date()))
    ) {
      WelcomeButtonView(
        title: "Flight Status",
        subTitle: "Departure and arrival information",
        imageName: "airplane",
        imageAngle: -45.0
      )
    }
  }
}

struct FlightStatusButton_Previews: PreviewProvider {
  static var previews: some View {
    FlightStatusButton(flightInfo: FlightData())
  }
}
