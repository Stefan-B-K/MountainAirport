
import Foundation

var longDateFormatter: DateFormatter {
  let ldf = DateFormatter()
  ldf.dateStyle = .long
  ldf.timeStyle = .none

  return ldf
}

var shortTimeFormatter: DateFormatter {
  let stf = DateFormatter()
  stf.dateStyle = .none
  stf.timeStyle = .short

  return stf
}
