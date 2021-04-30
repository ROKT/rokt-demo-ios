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
    @Published var accountId: String = ""
    @Published var accountIdHasError: Bool = false
    
    @Published var viewName: String = ""
    @Published var viewNameHasError: Bool = false
    
    @Published var placementLocation1: String = ""
    @Published var placementLocation1HasError: Bool = false
    
    @Published var placementLocation2: String = ""
    @Published var placementLocation2HasError: Bool = false
    
    func continueAction() {
        accountIdHasError = true
    }
}
