import Foundation

// MARK: - Data transfer struct between Account and Attributes screens

struct ShoppableAdsAccountData {
    let tagID: String
    let stripePublishableKey: String
    let viewName: String
}

// MARK: - ViewModel

class ShoppableAdsAttributesViewModel: ObservableObject {
    private static let maxAttributesCount = 30

    let accountData: ShoppableAdsAccountData

    // Pre-populated basic fields
    @Published var email: String
    @Published var firstname: String
    @Published var lastname: String
    @Published var confirmationref: String
    @Published var country: String
    @Published var sandbox: String

    // Dynamic additional attributes
    @Published var additionalAttributes: [KeyValue] = []

    init(accountData: ShoppableAdsAccountData) {
        self.accountData = accountData
        let defaults = ShoppableAdsDefaults.attributes
        email = defaults["email"] ?? ""
        firstname = defaults["firstname"] ?? ""
        lastname = defaults["lastname"] ?? ""
        confirmationref = defaults["confirmationref"] ?? ""
        country = defaults["country"] ?? ""
        sandbox = defaults["sandbox"] ?? ""

        // Pre-populate remaining defaults as additional attributes
        let basicKeys: Set<String> = ["email", "firstname", "lastname", "confirmationref", "country", "sandbox"]
        for (key, value) in defaults where !basicKeys.contains(key) {
            additionalAttributes.append(KeyValue(key: key, value: value))
        }
    }

    func addAttribute() {
        guard additionalAttributes.count < Self.maxAttributesCount else { return }
        additionalAttributes.append(KeyValue(key: "", value: ""))
    }

    func removeAttribute(at index: Int) {
        guard index >= 0 && index < additionalAttributes.count else { return }
        additionalAttributes.remove(at: index)
    }

    var canAddMoreAttributes: Bool {
        additionalAttributes.count < Self.maxAttributesCount
    }

    func getAllAttributes() -> [String: String] {
        var attrs: [String: String] = [:]
        if !email.isEmpty { attrs["email"] = email }
        if !firstname.isEmpty { attrs["firstname"] = firstname }
        if !lastname.isEmpty { attrs["lastname"] = lastname }
        if !confirmationref.isEmpty { attrs["confirmationref"] = confirmationref }
        if !country.isEmpty { attrs["country"] = country }
        if !sandbox.isEmpty { attrs["sandbox"] = sandbox }
        for kv in additionalAttributes where !kv.key.isEmpty && !kv.value.isEmpty {
            attrs[kv.key] = kv.value
        }
        return attrs
    }
}
