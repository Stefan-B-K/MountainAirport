
import SwiftUI

class AppEnvironment: ObservableObject {
  @Published var lastFlightId: Int?
  @Published var awardList: [AwardInformation] = []

  init() {
    awardList.append(
      AwardInformation(
        imageName: "first-visit-award",
        title: "First Visit",
        description: "Awarded the first time you open the app while at the airport.",
        awarded: true,
        stars: 1
      )
    )
    awardList.append(
      AwardInformation(
        imageName: "overnight-award",
        title: "Left Car Overnight",
        description: "You left you car parked overnight in one of our parking lots.",
        awarded: true,
        stars: 2
      )
    )
    awardList.append(
      AwardInformation(
        imageName: "meal-award",
        title: "Meal at Airport",
        description: "You used the app to receive a discount at one of our restaurants.",
        awarded: false,
        stars: 2
      )
    )
    awardList.append(
      AwardInformation(
        imageName: "first-flight-award",
        title: "First Flight",
        description: "You checked in for a flight using the app for the first time.",
        awarded: true,
        stars: 3
      )
    )
    awardList.append(
      AwardInformation(
        imageName: "shopping-award",
        title: "Almost Duty Free",
        description: "You used the app to receive a discount at one of our vendors.",
        awarded: true,
        stars: 2
      )
    )
    awardList.append(
      AwardInformation(
        imageName: "rainy-day-award",
        title: "Rainy Day",
        description: "You flight was delayed because of weather.",
        awarded: false,
        stars: 3
      )
    )
    awardList.append(
      AwardInformation(
        imageName: "return-home-award",
        title: "Welcome Home",
        description: "Your returned to the airport after leaving from it.",
        awarded: true,
        stars: 2
      )
    )
  }
}
