
import SwiftUI

struct FlightTerminalMap: View {
  var flight: FlightInformation
  @State private var showPath = false

  let gateAPaths = [
    [
      CGPoint(x: 360, y: 128),
      CGPoint(x: 225, y: 128),
      CGPoint(x: 225, y: 70)
    ],
    [
      CGPoint(x: 360, y: 128),
      CGPoint(x: 172, y: 128),
      CGPoint(x: 172, y: 70)
    ],
    [
      CGPoint(x: 360, y: 128),
      CGPoint(x: 116, y: 128),
      CGPoint(x: 116, y: 70)
    ],
    [
      CGPoint(x: 360, y: 128),
      CGPoint(x: 46, y: 128)
    ],
    [
      CGPoint(x: 360, y: 128),
      CGPoint(x: 116, y: 128),
      CGPoint(x: 116, y: 187),
      CGPoint(x: 46, y: 187)
    ]
  ]

  let gateBPaths = [
    [
      CGPoint(x: 0, y: 128),
      CGPoint(x: 142, y: 128),
      CGPoint(x: 142, y: 70)
    ],
    [
      CGPoint(x: 0, y: 128),
      CGPoint(x: 197, y: 128),
      CGPoint(x: 197, y: 70)
    ],
    [
      CGPoint(x: 0, y: 128),
      CGPoint(x: 252, y: 128),
      CGPoint(x: 252, y: 70)
    ],
    [
      CGPoint(x: 0, y: 128),
      CGPoint(x: 315, y: 128)
    ],
    [
      CGPoint(x: 0, y: 128),
      CGPoint(x: 252, y: 128),
      CGPoint(x: 252, y: 185),
      CGPoint(x: 315, y: 185)
    ]
  ]
  
  var walkingAnimation: Animation {
    .linear(duration: 3.0)
    .repeatForever(autoreverses: false)
  }

  func gatePath(_ proxy: GeometryProxy) -> [CGPoint] {
    if let gateNumber = flight.gateNumber {
      var pathPoints: [CGPoint]
      if flight.terminalName == "A" {
        pathPoints = gateAPaths[gateNumber - 1]
      } else {
        pathPoints = gateBPaths[gateNumber - 1]
      }

      let ratioX = proxy.size.width / 360.0
      let ratioY = proxy.size.height / 480.0
      var points: [CGPoint] = []
      for pnt in pathPoints {
        let newPoint = CGPoint(
          x: pnt.x * ratioX, y: pnt.y * ratioY
        )
        points.append(newPoint)
      }
      return points
    }
    return []
  }

  var mapName: String {
    "terminal-\(flight.terminalName)-map".lowercased()
  }

  var body: some View {
    Image(mapName)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .overlay(
        GeometryReader { proxy in
          WalkPath(points: gatePath(proxy))
            .trim(to: showPath ? 1.0 : 0.0)
            .stroke(Color.white, lineWidth: 3.0)
            .animation(walkingAnimation, value: showPath)
        }
          .onAppear() {
            showPath = true
          }
      )
  }
}

struct WalkPath: Shape {
  var points: [CGPoint]

  func path(in rect: CGRect) -> Path {
    return Path { path in
      guard points.count > 1 else { return }
      path.addLines(points)
    }
  }
}





struct FlightTerminalMap_Previews: PreviewProvider {
  static var testGateA: FlightInformation {
    let flight = FlightData.generateTestFlight(date: Date())
    flight.gate = "A3"
    return flight
  }

  static var testGateB: FlightInformation {
    let flight = FlightData.generateTestFlight(date: Date())
    flight.gate = "B4"
    return flight
  }

  static var previews: some View {
    Group {
      FlightTerminalMap(flight: testGateA)
      FlightTerminalMap(flight: testGateB)
    }
  }
}
