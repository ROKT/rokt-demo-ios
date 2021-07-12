//
//  CustomerDetailsViewModelTests.swift
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

class CustomerDetailsViewModelTests: XCTestCase {

    func testGetAttributes() throws {
        // arrange
        let customerDetailSVM = CustomerDetailsViewModel(customerDetails:
                                                            CustomerDetailsModel(state: "NSW",
                                                                                 postcode: "2000",
                                                                                 country: ["AU", "US"]),
                                                         advancedDetails: ["test":"true"],
                                                         accountDetail:
                                                            AccountDetailViewData(accountId: "",
                                                                                  viewName: "",
                                                                                  placementLocation1: "",
                                                                                  placementLocation2: ""))
        // act
        let attributes = customerDetailSVM.getAttributes()
        // assert
        let expectedAttributes = ["state":"NSW",
                                  "postcode":"2000",
                                  "country":"AU",
                                  "test":"true"]
        XCTAssertEqual(attributes, expectedAttributes)
    }


}
