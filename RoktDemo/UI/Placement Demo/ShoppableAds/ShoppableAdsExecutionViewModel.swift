import Foundation
import Rokt_Widget

class ShoppableAdsExecutionViewModel: ObservableObject {
    let accountData: ShoppableAdsAccountData
    let attributes: [String: String]

    @Published var statusMessage: String = "Selecting Shoppable Ads..."
    @Published var eventLog: [String] = []

    init(accountData: ShoppableAdsAccountData, attributes: [String: String]) {
        self.accountData = accountData
        self.attributes = attributes
    }

    func executeShoppableAds() {
        statusMessage = "Selecting Shoppable Ads..."

        // SDK init and Stripe registration already done in ShoppableAdsAccountView
        Rokt.selectShoppableAds(
            identifier: accountData.viewName,
            attributes: attributes
        ) { [weak self] event in
            DispatchQueue.main.async {
                self?.handleEvent(event)
            }
        }
    }

    private func handleEvent(_ event: RoktEvent) {
        switch event {
        case is RoktEvent.PlacementReady:
            statusMessage = "Placement displayed"
            eventLog.append("PlacementReady")
        case is RoktEvent.PlacementClosed:
            eventLog.append("PlacementClosed")
        case let e as RoktEvent.CartItemInstantPurchase:
            eventLog.append("Purchase: \(e.catalogItemId)")
        case let e as RoktEvent.CartItemInstantPurchaseFailure:
            eventLog.append("PurchaseFailed: \(e.error ?? "unknown")")
        case is RoktEvent.InstantPurchaseDismissal:
            eventLog.append("Dismissed")
        default:
            eventLog.append("\(type(of: event))")
        }
    }
}
