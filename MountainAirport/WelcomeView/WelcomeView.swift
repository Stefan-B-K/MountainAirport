
import SwiftUI

struct WelcomeView: View {
  @StateObject private var flightInfo = FlightData()
  @State private var showNextFlight = false
  @StateObject private var appEnvironment = AppEnvironment()
  
  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        Text("Mountain Airport")
          .font(.title)
          .fontWeight(.semibold)
          .padding([.leading, .top])
        ZStack(alignment: .topLeading) {
          Image("welcome-background")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
          VStack {
            WelcomeAnimation()
              .foregroundColor(.white)
              .frame(height: 40)
              .padding(.top)
            LazyVGrid(columns: [GridItem(.fixed(160)), GridItem(.fixed(160))],
                      spacing: 15) {
              FlightStatusButton(flightInfo: flightInfo)
              SearchFlightsButton(flightInfo: flightInfo)
              AwardsButton()
              TimelineButton(flightInfo: flightInfo)
              if let id = appEnvironment.lastFlightId,
                 let lastFlight = flightInfo.getFlightById(id) {
                LastViewedButton(lastFlight: lastFlight)
              } else {
                Spacer()
              }
              
            }.font(.title)
              .foregroundColor(.white)
            .padding()
          }
        }
        .navigationTitle("Home")
        .navigationBarHidden(true)
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .environmentObject(appEnvironment)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView()
  }
}
