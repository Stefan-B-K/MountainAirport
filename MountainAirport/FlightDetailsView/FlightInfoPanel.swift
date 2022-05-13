
import SwiftUI

extension AnyTransition {
  static var buttonNameTransition: AnyTransition {
    .slide
  }
}


struct FlightInfoPanel: View {
  var flight: FlightInformation
  @State private var showTerminal = false
  
  var timeFormatter: DateFormatter {
    let tdf = DateFormatter()
    tdf.timeStyle = .short
    tdf.dateStyle = .none
    return tdf
  }
  
  var body: some View {
    HStack(alignment: .top) {
      Image(systemName: "info.circle")
        .resizable()
        .frame(width: 35, height: 35, alignment: .leading)
      VStack(alignment: .leading) {
        Text("Flight Details")
          .font(.title2)
        if flight.direction == .arrival {
          Text("Arriving at Gate \(flight.gate)")
          Text("Flying from \(flight.otherAirport)")
        } else {
          Text("Departing from Gate \(flight.gate)")
          Text("Flying to \(flight.otherAirport)")
        }
        Text(flight.flightStatus) + Text(" (\(timeFormatter.string(from: flight.localTime)))")
        Button(action: {
          withAnimation() {
              showTerminal.toggle()
            }
        }, label: {
          HStack(alignment: .center) {
            Group {
              if showTerminal {
                Text("Hide Terminal Map")
              } else {
                Text("Show Terminal Map")
              }
            }.transition(.buttonNameTransition)
            Spacer()
            Image(systemName: "airplane.circle")
              .resizable()
              .frame(width: 30, height: 30)
              .padding(10)
              .rotationEffect(.degrees(showTerminal ? 90 : -90))
              .animation(.easeOut.speed(0.6), value: showTerminal)
              .scaleEffect(showTerminal ? 1.5 : 1.0)
              .animation(
                .spring(
                  response: 0.5,
                  dampingFraction: 0.3,
                  blendDuration: 0
                ),
                value: showTerminal
              )
          }
        })
        if showTerminal {
          FlightTerminalMap(flight: flight)
            .transition(.buttonNameTransition)
        }
        Spacer()
        
      }
    }
  }
}

struct FlightInfoPanel_Previews: PreviewProvider {
  static var previews: some View {
    FlightInfoPanel(
      flight: FlightData.generateTestFlight(date: Date())
    )
  }
}
