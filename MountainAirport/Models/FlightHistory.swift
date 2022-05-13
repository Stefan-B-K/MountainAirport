
import SwiftUI

class FlightHistory: NSObject {
  var day: Int
  var flightId: Int
  var date: Date
  var direction: FlightDirection
  var status: FlightStatus
  var scheduledTime: Date
  var actualTime: Date?

  var shortDate: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d"
    return formatter.string(from: date)
  }

  var timeDifference: Int {
    guard let actual = actualTime else { return 60 }
    let diff = Calendar.current.dateComponents([.minute], from: scheduledTime, to: actual)
    // swiftlint:disable:next force_unwrapping
    return diff.minute!
  }

  var flightDelayDescription: String {
    if status == .canceled {
      return "Canceled"
    }

    if timeDifference < 0 {
      return "Early by \(-timeDifference) minutes."
    } else if timeDifference == 0 {
      return "On time"
    } else {
      return "Late by \(timeDifference) minutes."
    }
  }

  var delayColor: Color {
    if status == .canceled {
      return Color.init(red: 0.5, green: 0, blue: 0)
    }

    if timeDifference <= 0 {
      return Color.green
    }

    if timeDifference <= 15 {
      return Color.yellow
    }

    return Color.red
  }

  func calcOffset(_ width: CGFloat) -> CGFloat {
    CGFloat(CGFloat(day - 1) * width)
  }

  init(_ day: Int, id: Int, date: Date, direction: FlightDirection, status: FlightStatus, scheduledTime: Date, actualTime: Date?) {
    self.day = day
    self.flightId = id
    self.date = date
    self.direction = direction
    self.status = status
    self.scheduledTime = scheduledTime
    self.actualTime = actualTime
  }
}
