
import SwiftUI

struct AwardsButton: View {
  
  var body: some View {
    NavigationLink(
      destination: AwardsView()
    ) {
      WelcomeButtonView(
        title: "Your Awards",
        subTitle: "Earn rewards for your airport interactions",
        imageName: "star")
    }
  }
}

struct AwardsButton_Previews: PreviewProvider {
  static var previews: some View {
    AwardsButton()
  }
}
