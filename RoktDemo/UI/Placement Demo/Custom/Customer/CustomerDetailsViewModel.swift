//
//  CustomerDetailsViewModel.swift
//  RoktDemo
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import Foundation
class CustomerDetailsViewModel: ObservableObject {
    let customerDetails: CustomerDetailsModel
    let accountDetail: AccountDetailViewData
    
    @Published var state: String = ""
    @Published var postcode: String = ""
    @Published var countries: [String] = []
    @Published var selectedCountry: String = ""
    @Published var advancedDetailsKV: [KeyValue] = []
    
    internal init(customerDetails: CustomerDetailsModel,
                  advancedDetails: [String: String],
                  accountDetail: AccountDetailViewData) {
        self.customerDetails = customerDetails
        self.accountDetail = accountDetail
        
        state = customerDetails.state
        postcode = customerDetails.postcode
        countries = customerDetails.country
        selectedCountry = countries.first ?? ""
        
        advancedDetailsKV = []
        for (key, value) in advancedDetails {
            advancedDetailsKV.append(KeyValue(key: key, value: value))
        }
    }

    func addAttribute() {
        guard advancedDetailsKV.count < 20 else { return }
        advancedDetailsKV.append(KeyValue(key: "", value: ""))
    }
    
    var canAddMoreAttributes: Bool {
        return advancedDetailsKV.count < 20
    }

    private func getAttributes() -> [String: String] {
        var attributes : [String: String] = [:]
        if !state.isEmpty {
            attributes["state"] = state
        }
        if !postcode.isEmpty {
            attributes["postcode"] = postcode
        }
        if !selectedCountry.isEmpty {
            attributes["country"] = selectedCountry
        }
        for advancedDetail in advancedDetailsKV {
            if !advancedDetail.key.isEmpty && !advancedDetail.value.isEmpty {
                attributes[advancedDetail.key] = advancedDetail.value
            }
        }

        return attributes
    }
    
    func getConfirmationViewModel() -> ConfirmationViewModel {
        return ConfirmationViewModel(accountDetail: accountDetail, attributes: getAttributes())
    }

}

struct KeyValue: Hashable {
    var key: String
    var value: String
}
