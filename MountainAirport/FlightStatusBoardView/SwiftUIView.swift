//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
      ZStack {
        GeometryReader { proxy in
          Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
      }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
