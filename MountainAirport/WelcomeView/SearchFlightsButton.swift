
import SwiftUI

struct SearchFlightsButton: View {
  @ObservedObject var flightInfo: FlightData

  var body: some View {
    NavigationLink(
      destination: SearchFlights(
        flightData: flightInfo.flights
      )
    ) {
      WelcomeButtonView(
        title: "Search Flights",
        subTitle: "Search upcoming flights",
        imageName: "magnifyingglass"
      )
    }
  }
}

struct SearchFlightsButton_Previews: PreviewProvider {
  static var previews: some View {
    SearchFlightsButton(flightInfo: FlightData())
  }
}
