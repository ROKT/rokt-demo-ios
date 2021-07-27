//
//  FeatureWalkthroughViewModelTests.swift
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

class FeatureWalkthroughViewModelTests: XCTestCase {
    
    func testNavigationTitle() throws {
        // arrange
        let viewModel = getViewModel(selectedScreen: 0)
        // act
        let title = viewModel.getNavigationTitle()
        // assert
        XCTAssertEqual(title, "1/2")
    }
    
    func testNavigationButtonText() throws {
        // arrange
        let viewModel = getViewModel(selectedScreen: 0)
        // act
        let buttonText = viewModel.getNavigationButtonText()
        // assert
        XCTAssertEqual(buttonText, "NEXT")
    }
    
    func testScreenIsLast() throws {
        // arrange
        let viewModel = getViewModel(selectedScreen: 0)
        // act
        let isLast = viewModel.isLastScreen()
        // assert
        XCTAssertFalse(isLast)
    }

    func testLastNavigationTitle() throws {
        // arrange
        let viewModel = getViewModel(selectedScreen: 1)
        // act
        let title = viewModel.getNavigationTitle()
        // assert
        XCTAssertEqual(title, "2/2")
    }
    
    func testLastNavigationButtonText() throws {
        // arrange
        let viewModel = getViewModel(selectedScreen: 1)
        // act
        let buttonText = viewModel.getNavigationButtonText()
        // assert
        XCTAssertEqual(buttonText, "QUIT DEMO")
    }
    
    func testLastScreen() throws {
        // arrange
        let viewModel = getViewModel(selectedScreen: 1)
        // act
        let isLast = viewModel.isLastScreen()
        // assert
        XCTAssertTrue(isLast)
    }
    
    func testFormattedDate() throws {
        // arrange
        let viewModel = getViewModel(selectedScreen: 1)
        // act
        let date = Date(timeIntervalSince1970: 0)
        // assert
        XCTAssertEqual(viewModel.getFormattedDate(date), "197001011000000")
    }
    
    func testRandomEmail() {
        // arrange
        let viewModel = getViewModel(selectedScreen: 1)
        // act
        let randomisedEmail = viewModel.getAttributes()["email"]
        // assert
        XCTAssertNotEqual(randomisedEmail, "something@example.com")
    }
    
    private func getViewModel(selectedScreen: Int) -> FeatureWalkthroughViewModel {
        let screen = ScreenModel(title:
                                    "Embedded Placement (1)",
                                 description:
                                    """
The below preview shows an embedded placement without brand logos displayed. You can progress through the offers by clicking “Yes Please” or “No Thanks”.
\n
The placement UI can be customised to match your app, and create a native experience. This includes changing fonts, colours and multiple configurable options to alter the look and feel of the placement.

""",
                                 viewName: "testiOS", placeholderName: "Location1", type: "overlay",
                                 attributes: ["firstname":"name",
                                              "lastname":"family",
                                              "email":"something@example.com",
                                              "sandbox":"true", "country":"AU"])
        return FeatureWalkthroughViewModel(
            model:
                DefaultPlacementExamplesModel(title: "",
                                              shortDescription: "",
                                              longDescription: "",
                                              iconURL: "",
                                              tagID: "",
                                              screens:
                                                [screen, screen]), selectedScreen: selectedScreen)
    }


}
