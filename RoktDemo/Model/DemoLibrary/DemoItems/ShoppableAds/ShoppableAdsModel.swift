import Foundation

class ShoppableAdsModel: DemoItemModel {
    let defaultTagID: String
    let defaultViewName: String
    let defaultStripePublishableKey: String
    let defaultAttributes: [String: String]

    init(title: String,
         shortDescription: String,
         longDescription: String?,
         iconURL: String,
         defaultTagID: String,
         defaultViewName: String,
         defaultStripePublishableKey: String,
         defaultAttributes: [String: String]) {
        self.defaultTagID = defaultTagID
        self.defaultViewName = defaultViewName
        self.defaultStripePublishableKey = defaultStripePublishableKey
        self.defaultAttributes = defaultAttributes
        super.init(title: title,
                   shortDescription: shortDescription,
                   longDescription: longDescription,
                   iconURL: iconURL)
    }

    // MARK: - Codable

    enum CodingKeys: String, CodingKey {
        case defaultTagID
        case defaultViewName
        case defaultStripePublishableKey
        case defaultAttributes
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        defaultTagID = try container.decodeIfPresent(String.self, forKey: .defaultTagID) ?? ShoppableAdsDefaults.tagID
        defaultViewName = try container.decodeIfPresent(String.self, forKey: .defaultViewName) ?? ShoppableAdsDefaults.viewName
        defaultStripePublishableKey = try container.decodeIfPresent(String.self, forKey: .defaultStripePublishableKey) ?? ShoppableAdsDefaults.stripePublishableKey
        defaultAttributes = try container.decodeIfPresent([String: String].self, forKey: .defaultAttributes) ?? ShoppableAdsDefaults.attributes
        try super.init(from: decoder)
    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(defaultTagID, forKey: .defaultTagID)
        try container.encode(defaultViewName, forKey: .defaultViewName)
        try container.encode(defaultStripePublishableKey, forKey: .defaultStripePublishableKey)
        try container.encode(defaultAttributes, forKey: .defaultAttributes)
        try super.encode(to: encoder)
    }

    // MARK: - Hashable

    override func hash(into hasher: inout Hasher) {
        super.hash(into: &hasher)
        hasher.combine(defaultTagID)
        hasher.combine(defaultViewName)
        hasher.combine(defaultStripePublishableKey)
    }

    static func == (lhs: ShoppableAdsModel, rhs: ShoppableAdsModel) -> Bool {
        return lhs.title == rhs.title &&
            lhs.shortDescription == rhs.shortDescription &&
            lhs.defaultTagID == rhs.defaultTagID &&
            lhs.defaultViewName == rhs.defaultViewName
    }

    // MARK: - Factory

    static func defaultItem() -> ShoppableAdsModel {
        ShoppableAdsModel(
            title: "Shoppable Ads",
            shortDescription: "Test the Shoppable Ads experience with Stripe payment integration. Enter your account details and see live shoppable ad placements.",
            longDescription: "For SDK integration testing\n\nThis interactive demo lets you configure and test the Shoppable Ads feature.\n\nYou'll need a Rokt account ID (tag ID) and a Stripe publishable key to test payments.\n\nShoppable Ads always display as an overlay experience.\n",
            iconURL: "ShoppableAds",
            defaultTagID: ShoppableAdsDefaults.tagID,
            defaultViewName: ShoppableAdsDefaults.viewName,
            defaultStripePublishableKey: ShoppableAdsDefaults.stripePublishableKey,
            defaultAttributes: ShoppableAdsDefaults.attributes
        )
    }
}
