
import SwiftUI

struct PieSegment: Identifiable {
  var id = UUID()
  var fraction: Double
  var name: String
  var color: Color
}


struct HistoryPieChart: View {
  
  var onTimeCount: Int {
    flightHistory.filter { $0.timeDifference <= 0 }.count
  }
  var shortDelayCount: Int {
    flightHistory.filter { $0.timeDifference > 0 && $0.timeDifference <= 15 }.count
  }
  var longDelayCount: Int {
    flightHistory.filter { $0.timeDifference > 15 && $0.actualTime != nil }.count
  }
  var canceledCount: Int {
    flightHistory.filter { $0.status == .canceled }.count
  }
  var flightHistory: [FlightHistory]
  
  var pieElements: [PieSegment] {
    let historyCount = Double(flightHistory.count)
    let onTimeFrac = Double(onTimeCount) / historyCount
    let shortFrac = Double(shortDelayCount) / historyCount
    let longFrac = Double(longDelayCount) / historyCount
    let cancelFrac = Double(canceledCount) / historyCount

    let segments = [
      PieSegment(fraction: onTimeFrac, name: "On-Time", color: Color.green),
      PieSegment(fraction: shortFrac, name: "Short Delay", color: Color.yellow),
      PieSegment(fraction: longFrac, name: "Long Delay", color: Color.red),
      PieSegment(fraction: cancelFrac, name: "Canceled", color: Color(red: 0.5, green: 0, blue: 0))
    ]
    return segments.filter { $0.fraction > 0 }
  }

  
  var body: some View {
      HStack {
        VStack {
          GeometryReader { proxy in
            let radius = min(proxy.size.width, proxy.size.height) / 2.0
            let center = CGPoint(x: proxy.size.width / 2.0, y: proxy.size.height / 2.0)
            var startAngle = 360.0
            ForEach(pieElements) { segment in
              let endAngle = startAngle - segment.fraction * 360.0
              Path { pieChart in
                pieChart.move(to: center)
                pieChart.addArc(
                  center: center,
                  radius: radius,
                  startAngle: .degrees(startAngle),
                  endAngle: .degrees(endAngle),
                  clockwise: true
                )
                pieChart.closeSubpath()
                startAngle = endAngle
              }
              .foregroundColor(segment.color)
              .rotationEffect(.degrees(-90))
            }
          }
        }
        VStack {
          VStack(alignment: .leading) {
            ForEach(pieElements)  {segment in
              HStack() {
                Rectangle()
                  .frame(width: 20, height: 20)
                .foregroundColor(segment.color)
                Text(segment.name)
              }
            }
          }
          .padding()
        }
      }
  }
}




struct HistoryPieChart_Previews: PreviewProvider {
  static var previews: some View {
    HistoryPieChart(flightHistory: FlightData.generateTestFlight(date: Date()).history)
  }
}
