
import SwiftUI

struct TimelineButton: View {
  @ObservedObject var flightInfo: FlightData
  
  var body: some View {
    NavigationLink(
      destination: FlightTimelineView(
        flights: flightInfo.flights
          .filter { Calendar.current.isDate($0.localTime, inSameDayAs: Date()) }
      )
    ){
      WelcomeButtonView(
        title: "Flight Timeline",
        subTitle: "Flight Timeline",
        imageName: "timelapse")
    }
  }
}

struct TimelineButton_Previews: PreviewProvider {
  static var previews: some View {
    TimelineButton(flightInfo: FlightData())
  }
}
    
