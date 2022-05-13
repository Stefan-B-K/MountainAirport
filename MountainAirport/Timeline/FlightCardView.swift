
import SwiftUI

struct FlightCardView: View {
  var flight: FlightInformation
  
  func minutesBetween(_ start: Date, and end: Date) -> Int {
    let diff = Calendar.current.dateComponents([.minute], from: start, to: end)
    guard let minute = diff.minute else { return 0 }
    return abs(minute)
  }
  
  func flightTimeFraction(flight: FlightInformation) -> CGFloat {
    let now = Date()
    if flight.direction == .departure {
      if flight.localTime > now {
        return 0.0
      } else if flight.otherEndTime < now {
        return 1.0
      } else {
        let timeInFlight = minutesBetween(flight.localTime, and: now)
        let fraction = Double(timeInFlight) / Double(flight.flightTime)
        return CGFloat(fraction)
      }
    } else {
      if flight.otherEndTime > now {
        return 0.0
      } else if flight.localTime < now {
        return 1.0
      } else {
        let timeInFlight = minutesBetween(flight.otherEndTime, and: now)
        let fraction = Double(timeInFlight) / Double(flight.flightTime)
        return CGFloat(fraction)
      }
    }
  }
  
  var body: some View {
    VStack {
      HStack {
        Spacer()
        Text(flight.statusBoardName)
        Spacer()
      }
      HStack {
        DepartureTimeView(flight: flight)
        FlightProgressView(flight: flight, progress: flightTimeFraction(flight: flight))
        ArrivalTimeView(flight: flight)
      }
      FlightMapView(startCoordinate: flight.startingAirportLocation,
                    endCoordinate: flight.endingAirportLocation,
                    progress: flightTimeFraction(flight: flight))
      .frame(width: 300, height: 300)
    }
    .padding()
    .background(Color.gray.opacity(0.3))
    .clipShape( RoundedRectangle(cornerRadius: 20) )
    .overlay( RoundedRectangle(cornerRadius: 20).stroke() )
  }
}

struct DepartureTimeView: View {
  var flight: FlightInformation
  
  var body: some View {
    VStack {
      if flight.direction == .arrival {
        Text(flight.otherAirport)
      }
      Text(shortTimeFormatter.string(from: flight.departureTime))
    }
  }
}

struct ArrivalTimeView: View {
  var flight: FlightInformation
  
  var body: some View {
    VStack {
      if flight.direction == .departure {
        Text(flight.otherAirport)
      }
      Text(shortTimeFormatter.string(from: flight.arrivalTime))
    }
  }
}

struct FlightProgressView: View {
  var flight: FlightInformation
  var progress: CGFloat
  
  var body: some View {
    GeometryReader { proxy in
      Image(systemName: "airplane")
        .resizable()
        .offset(x: proxy.size.width * progress)
        .frame(width: 20, height: 20)
        .foregroundColor(flight.statusColor)
    }.padding([.trailing], 20)
  }
}



struct FlightCardView_Previews: PreviewProvider {
  static var previews: some View {
    FlightCardView(
      flight: FlightData.generateTestFlight(date: Date())
    )
  }
}
