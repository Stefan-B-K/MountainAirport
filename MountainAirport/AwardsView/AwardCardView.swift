
import SwiftUI

struct AwardCardView: View {
  var award: AwardInformation
 

  var body: some View {
    VStack {
      Image(award.imageName)
        .shadow(radius: 10)
      Text(award.title)
        .font(.title3)
      Text(award.description)
        .font(.footnote)
      AwardStars(stars: award.stars)
        .foregroundColor(.yellow)
        .shadow(color: .black, radius: 5)
      Spacer()
    }
    .padding(10.0)
    .background(
      LinearGradient(
        gradient: Gradient(
          colors: [Color.white, Color(red: 0.0, green: 0.5, blue: 1.0)]
        ),
        startPoint: .bottomLeading,
        endPoint: .topTrailing)
    )
    .background(Color.white)
    .saturation(award.awarded ? 1.0 : 0.0)
    .opacity(award.awarded ? 1.0 : 0.3)
    .clipShape(RoundedRectangle(cornerRadius: 25.0))
  }
}

struct AwardCardView_Previews: PreviewProvider {
  static var previews: some View {
    let award = AwardInformation(
      imageName: "first-visit-award",
      title: "First Visit",
      description: "Awarded the first time you open the app while at the airport.",
      awarded: true,
      stars: 3
    )
    AwardCardView(award: award)
      .frame(width: 150, height: 220)
      .padding()
      .background(Color.black)
  }
}
