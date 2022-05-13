
import SwiftUI

struct AwardGrid: View {
  var title: String
  var awards: [AwardInformation]
  @Binding var selected: AwardInformation?
  var namespace: Namespace.ID
  
  var body: some View {
    Section(
      header: Text(title)
        .font(.title)
        .foregroundColor(.white)
    ) {
      ForEach(awards, id: \.self) { award in
        NavigationLink(destination: AwardDetails(award: award)) {
          AwardCardView(award: award)
            .foregroundColor(.black)
            .aspectRatio(0.67, contentMode: .fit)
            .onTapGesture {
              withAnimation {
                selected = award
              }
            }
            .matchedGeometryEffect(id: award.hashValue, in: namespace, anchor: .topLeading)
        }
      }
    }
  }
}

struct AwardGrid_Previews: PreviewProvider {
  @Namespace static var namespace

  static var previews: some View {
    AwardGrid(
      title: "Test",
      awards: AppEnvironment().awardList, selected: .constant(nil), namespace: namespace
    )
  }
}
