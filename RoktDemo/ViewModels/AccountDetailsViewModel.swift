//
//  AccountDetailsViewModel.swift
//  RoktDemo
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import Foundation

class AccountDetailsViewModel: ObservableObject {
    let model: CustomConfigurationPageModel
    @Published var accountId: String = ""
    @Published var accountIdHasError: Bool = false
    @Published var accountIdError: String = "Accound ID can't be empty!"
    @Published var viewName: String = ""
    @Published var placementLocation1: String = ""
    @Published var placementLocation2: String = ""
    
    init(_ model: CustomConfigurationPageModel) {
        self.model = model
        accountId = model.accountDetails.accountID
        viewName = model.accountDetails.viewName
        placementLocation1 = model.accountDetails.placementLocation1
        placementLocation2 = model.accountDetails.placementLocation2
    }
    
    func isValidToContinue() -> Bool {
        accountIdHasError = ValidationService.isEmpty(accountId)
        return !accountIdHasError
    }
    
    func getCustomerDetailsViewModel() -> CustomerDetailsViewModel {
        return CustomerDetailsViewModel(customerDetails: model.customerDetails,
                                        advancedDetails: model.advancedDetails, 
                                        accountDetail:
                                            AccountDetailViewData(accountId: accountId,
                                                                  viewName: viewName,
                                                                  placementLocation1: placementLocation1,
                                                                  placementLocation2: placementLocation2))
    }
}

struct AccountDetailViewData {
    var accountId: String
    var viewName: String
    var placementLocation1: String
    var placementLocation2: String
}
