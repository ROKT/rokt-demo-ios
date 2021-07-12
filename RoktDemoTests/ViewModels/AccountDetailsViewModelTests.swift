//
//  AccountDetailsViewModelTests.swift
//  RoktDemoTests
//
//  Copyright 2020 Rokt Pte Ltd
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import XCTest

class AccountDetailsViewModelTests: XCTestCase {

    func testAccountDetailsViewModelInitiation() {
        // arrange and act
        let viewModel = AccountDetailsViewModel(
            CustomConfigurationPageModel(title: "title",
                                         shortDescription: "",
                                         longDescription: "",
                                         iconURL: "",
                                         accountDetails:
                                            AccountDetailsModel(accountID: "123",
                                                                viewName: "viewName",
                                                                placementLocation1: "placementLocation1",
                                                                placementLocation2: "placementLocation2"),
                                         customerDetails:
                                            CustomerDetailsModel(state: "",
                                                                 postcode: "",
                                                                 country: ["AU", "US"]),
                                         advancedDetails: ["":""]
                                         ))
        
        // assert
        XCTAssertEqual(viewModel.accountId, "123", "AccountId need to be adjusted")
        XCTAssertEqual(viewModel.viewName, "viewName", "ViewName need to be adjusted")
        XCTAssertEqual(viewModel.placementLocation1, "placementLocation1", "PlacementLocation1 need to be adjusted")
        XCTAssertEqual(viewModel.placementLocation2, "placementLocation2", "PlacementLocation2 need to be adjusted")
    }
    
    func testAccountDetailsContinueActionValidationFail() {
        // arrange
        let viewModel = AccountDetailsViewModel(
            CustomConfigurationPageModel(title: "title",
                                         shortDescription: "",
                                         longDescription: "",
                                         iconURL: "",
                                         accountDetails:
                                            AccountDetailsModel(accountID: "",
                                                                viewName: "",
                                                                placementLocation1: "",
                                                                placementLocation2: ""),
                                         customerDetails:
                                            CustomerDetailsModel(state: "",
                                                                 postcode: "",
                                                                 country: ["AU", "US"]),
                                         advancedDetails: ["":""]
                                         ))
        // act
        XCTAssertFalse(viewModel.isValidToContinue())
        
        // assert
        XCTAssertTrue(viewModel.accountIdHasError)
        XCTAssertEqual(viewModel.accountIdError, "Accound ID can't be empty!", "accountID empty validation")
    }
    
    func testAccountDetailsContinueActionValidationPass() {
        // arrange
        let viewModel = AccountDetailsViewModel(
            CustomConfigurationPageModel(title: "title",
                                         shortDescription: "",
                                         longDescription: "",
                                         iconURL: "",
                                         accountDetails:
                                            AccountDetailsModel(accountID: "123",
                                                                viewName: "viewName",
                                                                placementLocation1: "placementLocation1",
                                                                placementLocation2: "placementLocation2"),
                                         customerDetails:
                                            CustomerDetailsModel(state: "",
                                                                 postcode: "",
                                                                 country: ["AU", "US"]),
                                         advancedDetails: ["":""]
                                         ))
        // act
        XCTAssertTrue(viewModel.isValidToContinue())
        
        // assert
        XCTAssertFalse(viewModel.accountIdHasError)
    }
    
}
