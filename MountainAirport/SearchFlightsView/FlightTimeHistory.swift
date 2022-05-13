
import SwiftUI

struct FlightTimeHistory: View {
  var flight: FlightInformation

  let minuteRange = 75.0

  func minuteLength(_ minutes: Int, proxy: GeometryProxy) -> CGFloat {
    let pointsPerMinute = proxy.size.width / minuteRange
    return Double(abs(minutes)) * pointsPerMinute
  }

  func minuteOffset(_ minutes: Int, proxy: GeometryProxy) -> CGFloat {
    let pointsPerMinute = proxy.size.width / minuteRange
    let offset = minutes < 0 ? 15 + minutes : 15
    return CGFloat(offset) * pointsPerMinute
  }

  func chartGradient(_ history: FlightHistory) -> Gradient {
    if history.status == .canceled {
      return Gradient(
        colors: [
          Color.green,
          Color.yellow,
          Color.red,
          Color(red: 0.5, green: 0, blue: 0)
        ]
      )
    }

    if history.timeDifference <= 0 {
      return Gradient(colors: [Color.green])
    }
    if history.timeDifference <= 15 {
      return Gradient(colors: [Color.green, Color.yellow])
    }
    return Gradient(colors: [Color.green, Color.yellow, Color.red])
  }

  func minuteLocation(_ minutes: Int, proxy: GeometryProxy) -> CGFloat {
    let minMinutes = -15
    let pointsPerMinute = proxy.size.width / minuteRange
    let offset = CGFloat(minutes - minMinutes) * pointsPerMinute
    return offset
  }

  var body: some View {
    ZStack {
      Image("background-view")
        .resizable()
        .aspectRatio(contentMode: .fill)
      VStack {
        Text("On Time History for \(flight.statusBoardName)")
          .font(.title2)
          .padding(.top, 30)
        ScrollView {
          DelayBarChart(
            flight: flight
          )
        }
        HistoryPieChart(flightHistory: flight.history)
          .font(.footnote)
          .frame(width: 250, height: 250)
          .padding(5)
      }
    }.foregroundColor(.white)
  }
}

struct FlightTimeHistory_Previews: PreviewProvider {
  static var previews: some View {
    FlightTimeHistory(
      flight: FlightData.generateTestFlight(date: Date())
    )
  }
}
