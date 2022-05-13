//

import SwiftUI

struct AwardStars: View {
  var stars = 3
    var body: some View {
      Canvas { context, size in
        guard let starSymbol = context.resolveSymbol(id: 0) else { return }
        let centerOffset = (size.width - (20 * Double(stars))) / 2
        context.translateBy(x: centerOffset, y: size.height / 2)
        
        for star in 0..<stars {
          let starXPosition = Double(star) * 20
          let point = CGPoint(x: starXPosition + 8, y: 0)
          context.draw(starSymbol, at: point)
        }
      } symbols: {
        Image(systemName: "star.fill")
          .resizable()
          .frame(width: 15, height: 15)
          .tag(0)
      }
    }
}

struct AwardStars_Previews: PreviewProvider {
    static var previews: some View {
        AwardStars()
    }
}
