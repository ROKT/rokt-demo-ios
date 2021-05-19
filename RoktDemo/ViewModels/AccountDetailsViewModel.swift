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
        accountId = model.customerDetails.accountID
        viewName = model.customerDetails.viewName
        placementLocation1 = model.customerDetails.placementLocation1
        placementLocation2 = model.customerDetails.placementLocation2
    }
    
    func continueAction() {
        accountIdHasError = ValidationService.isEmpty(accountId)
        if accountIdHasError {
            // don't navigate if there is validation error
            return
        }
        let accountDetail = AccountDetailModel(accountId: accountId,
                                               viewName: viewName,
                                               placementLocation1: placementLocation1,
                                               placementLocation2: placementLocation2)
       
    }
}

struct AccountDetailModel {
    var accountId: String
    var viewName: String
    var placementLocation1: String
    var placementLocation2: String
}
