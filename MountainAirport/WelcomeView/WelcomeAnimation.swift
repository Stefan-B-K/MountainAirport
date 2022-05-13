
import SwiftUI

struct WelcomeAnimation: View {
  private var startTime = Date()
  private let animationLength = 5.0

    var body: some View {
      TimelineView(.animation) { timelineContext in
        Canvas { graphicContext, size in
          guard let airPlane = graphicContext.resolveSymbol(id: 0) else { return }
          let timePosition = (timelineContext.date.timeIntervalSince(startTime))
            .truncatingRemainder(dividingBy: animationLength)
          let xPosition = timePosition / animationLength * size.width
          graphicContext.draw(
            airPlane,
            at: .init(x: xPosition, y: size.height / 2.0)
          )
        } symbols: {
          Image(systemName: "airplane")
            .resizable()
            .aspectRatio(1.0, contentMode: .fit)
            .frame(height: 40)
            .tag(0)
        }
      }
    }
}

struct WelcomeAnimation_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeAnimation()
    }
}
