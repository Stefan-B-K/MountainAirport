
import SwiftUI

struct LastViewedButton: View {
  let lastFlight: FlightInformation
  
  var body: some View {
    NavigationLink(
      destination: FlightDetails(flight: lastFlight)
    ) {
      WelcomeButtonView(
        title: "Last Viewed Flight",
        subTitle: lastFlight.flightName,
        imageName: "suit.heart.fill"
      )
    }
  }
}

struct LastViewedButton_Previews: PreviewProvider {
  static var previews: some View {
    return LastViewedButton(lastFlight: FlightData.generateTestFlight(date: Date()))
  }
}
