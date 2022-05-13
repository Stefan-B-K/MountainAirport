
import SwiftUI

struct DelayBarChart: View {
  var flight: FlightInformation
  @State private var showBars = false
  let minuteRange = CGFloat(75)

  func minuteLength(_ minutes: Int, proxy: GeometryProxy) -> CGFloat {
    let pointsPerMinute = proxy.size.width / minuteRange
    return CGFloat(abs(minutes)) * pointsPerMinute
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

  func barAnimation(_ barNumber: Int) -> Animation {
    return .easeInOut.delay(Double(barNumber) * 0.1)
  }

  var body: some View {
    VStack {
      ForEach(flight.history, id: \.day) { history in
        HStack {
          Text("\(history.day) day(s) ago")
            .frame(width: 110, alignment: .trailing)
          GeometryReader { proxy in
            Rectangle()
              .fill(
                LinearGradient(
                  gradient: chartGradient(history),
                  startPoint: .leading,
                  endPoint: .trailing
                )
              )
              .frame(
                width: showBars ?
                  minuteLength(history.timeDifference, proxy: proxy) :
                  0
              )
              .offset(
                x: showBars ?
                  minuteOffset(history.timeDifference, proxy: proxy) :
                  minuteOffset(0, proxy: proxy)
              )
              .animation(
                barAnimation(history.day),
                value: showBars
              )
            ForEach(-1..<6) { val in
              Rectangle()
                .stroke(val == 0 ? Color.white : Color.gray, lineWidth: 1.0)
                .frame(width: 1)
                .offset(x: minuteLocation(val * 10, proxy: proxy))
            }
          }
        }
      }
      .padding()
      .background(
        Color.white.opacity(0.2)
      )
    }
    .onAppear {
      showBars = true
    }
  }
}

struct DelayBarChart_Previews: PreviewProvider {
  static var previews: some View {
    DelayBarChart(
      flight: FlightData.generateTestFlight(date: Date())
    )
    .background(
      Color.gray.opacity(0.4)
    )
  }
}
