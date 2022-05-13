
import SwiftUI

struct AwardsView: View {
  @EnvironmentObject var flightNavigation: AppEnvironment
  @State var selectedAward: AwardInformation?
  @Namespace var cardNamespace

  var awardArray: [AwardInformation] { flightNavigation.awardList }
  var activeAwards: [AwardInformation] { awardArray.filter { $0.awarded } }
  var inactiveAwards: [AwardInformation] { awardArray.filter { !$0.awarded } }
  var awardColumns: [GridItem] {
    [GridItem(.adaptive(minimum: 150, maximum: 170))]
  }

  var body: some View {
    ZStack {
      if let award = selectedAward {
        AwardDetails(award: award)
          .background(Color.white)
          .shadow(radius: 5.0)
          .clipShape(RoundedRectangle(cornerRadius: 20.0))
          .onTapGesture {
            withAnimation() {
              selectedAward = nil
            }
          }
          .matchedGeometryEffect(id: award.hashValue, in: cardNamespace, anchor: .topLeading)
          .navigationTitle(award.title)
      } else {
        ScrollView {
          LazyVGrid(columns: awardColumns) {
            AwardGrid(
              title: "Awarded",
              awards: activeAwards,
              selected: $selectedAward, namespace: cardNamespace
            )
            AwardGrid(
              title: "Not Awarded",
              awards: inactiveAwards,
              selected: $selectedAward, namespace: cardNamespace
            )
          }
        }
        .navigationTitle("Your Awards")
      }
    }
  }
}

struct AwardsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      AwardsView()
    }.navigationViewStyle(StackNavigationViewStyle())
    .environmentObject(AppEnvironment())
  }
}
