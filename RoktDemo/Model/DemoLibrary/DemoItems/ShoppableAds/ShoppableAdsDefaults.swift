import Foundation

struct ShoppableAdsDefaults {
    static let tagID = "3068704822624787054"
    static let viewName = "StgRoktShoppableAds"
    static let stripePublishableKey = "" // User must provide
    static let applePayMerchantId = "merchant.rokt.demoapp"
    /// Bare URL scheme used for Afterpay redirects. Must be registered under
    /// CFBundleURLSchemes in Info.plist; Stripe returns to "<scheme>://rokt-payment-return".
    static let paymentURLScheme = "rokt"

    static let attributes: [String: String] = [
        "email": "jenny.smith@example.com",
        "firstname": "Jenny",
        "lastname": "Smith",
        "confirmationref": "ORD-12345",
        "country": "US",
        "sandbox": "true",
        "shippingaddress1": "123 Main St",
        "shippingaddress2": "Apt 4B",
        "shippingcity": "New York",
        "shippingstate": "NY",
        "shippingzipcode": "10001",
        "shippingcountry": "US",
        "billingzipcode": "07762",
        "paymenttype": "ApplePay",
        "last4digits": "4444",
    ]
}
