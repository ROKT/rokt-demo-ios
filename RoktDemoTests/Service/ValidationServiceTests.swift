//
//  ValidationServiceTests.swift
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

class ValidationServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIsEmptyReturnFalse() throws {
        let isValid = ValidationService.isEmpty("something")
        
        XCTAssertFalse(isValid)
    }
    
    func testIsEmptyValid() throws {
        let isValid = ValidationService.isEmpty("")
        
        XCTAssertTrue(isValid)
    }
    
    func testIsEmptyNil() throws {
        let isValid = ValidationService.isEmpty(nil)
        
        XCTAssertTrue(isValid)
    }

}
