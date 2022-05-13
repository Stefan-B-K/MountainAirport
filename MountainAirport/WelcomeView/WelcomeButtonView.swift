
import SwiftUI

struct WelcomeButtonView: View {
  var title: String
  var subTitle: String
  var imageName: String
  var imageAngle: Double = 0.0
  
  var body: some View {
    VStack(alignment: .leading) {
      Image(systemName: imageName)
        .resizable()
        .frame(width: 30, height: 30)
        .padding(10)
        .background(
          Circle()
            .foregroundColor(.white)
            .opacity(0.3)
        )
        .rotationEffect(.degrees(imageAngle))
      Spacer()
      Text(title)
        .font(.title)
        .multilineTextAlignment(.leading)
      Text(subTitle)
        .font(.subheadline)
    }
    .foregroundColor(.white)
    .padding()
    .frame(width: 155, height: 220, alignment: .leading)
    .background(Image("link-pattern")
      .resizable()
      .clipped()
    ).shadow(radius: 10)
  }
}

struct WelcomeButtonView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeButtonView(
      title: "Flight Status",
      subTitle: "Departure and Arrival Information",
      imageName: "airplane",
      imageAngle: -45.0
    )
  }
}
