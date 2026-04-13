import Foundation

class ShoppableAdsAccountViewModel: ObservableObject {
    @Published var tagID: String
    @Published var tagIDHasError: Bool = false
    @Published var tagIDError: String = "Account ID can't be empty!"
    @Published var stripePublishableKey: String
    @Published var stripeKeyHasError: Bool = false
    @Published var stripeKeyError: String = "Stripe Publishable Key can't be empty!"
    @Published var viewName: String
    init() {
        tagID = ShoppableAdsDefaults.tagID
        stripePublishableKey = ShoppableAdsDefaults.stripePublishableKey
        viewName = ShoppableAdsDefaults.viewName
    }

    func isValidToContinue() -> Bool {
        tagIDHasError = ValidationService.isEmpty(tagID)
        stripeKeyHasError = ValidationService.isEmpty(stripePublishableKey)
        return !tagIDHasError && !stripeKeyHasError
    }

    func getAccountData() -> ShoppableAdsAccountData {
        ShoppableAdsAccountData(
            tagID: tagID,
            stripePublishableKey: stripePublishableKey,
            viewName: viewName
        )
    }
}
