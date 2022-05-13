
import SwiftUI

struct HighlightActionView: View {
  var flightId: Int
  @Binding var highlightedIds: [Int]
  
  func toggleHighlight() {
    if let firstID = highlightedIds.firstIndex(where: { $0 == flightId }) {
      highlightedIds.remove(at: firstID)
    } else {
      highlightedIds.append(flightId)
    }
    
  }
  var body: some View {
    Button {
      toggleHighlight()
    } label: {
      Image(systemName: "rectangle.and.hand.point.up.left.filled")
        .tint(.yellow)
    }
  }
}

struct HighlightActionView_Previews: PreviewProvider {
  static var previews: some View {
    HighlightActionView(flightId: 1, highlightedIds: .constant([1]))
  }
}
