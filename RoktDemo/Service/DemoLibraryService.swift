//
//  DemoLibraryService.swift
//  RoktDemo
//
//  Copyright 2020 Rokt Pte Ltd
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import Foundation

struct DemoLibraryService {
    static func getDemoLibrary() -> DemoLibraryModel {
        return
            DemoLibraryModel(demoTitle: "Demo Library",
                             demoDescription: """
            Discover why Rokt is the easiest and most powerful way to optimize value across both your customer engagement and revenue objectives.

            Explore how our award-winning Machine Learning algorithms power stronger revenue outcomes for our clients by providing a more personalized experience for each customer at scale.
            """,
                             defaultPlacementsExamples:
                                DefaultPlacementExamplesModel(title: "Feature Walkthrough",
                                                              shortDescription: "View various examples of Rokt placements and offers that can be used or combined with your native app integration. ",
                                                              longDescription: """
                                The in-app feature walkthrough highlights the various placement and offer types that are available to native app integrations.

                                This includes overlay and embedded placements as well as email, traffic, phone, and app install offers.
                                """,
                                                              iconURL: "FeatureWalkthrough",
                                                              tagID: "2754655826098840951",
                                                              screens: [
                                                              ScreenModel(title: "Embedded Placement (1)", description: """
The below preview shows an embedded placement without brand logos displayed. You can progress through the offers by clicking “Yes Please” or “No Thanks”.
\n
The placement UI can be customised to match your app, and create a native experience. This includes changing fonts, colours and multiple configurable options to alter the look and feel of the placement.

""", viewName: "testiOS", placeholderName: "Location1", type: "embedded", attributes: ["firstname":"danial", "lastname":"m",  "email":"something@example.com", "sandbox":"true", "country":"AU"]),
                                                                ScreenModel(title: "Embedded Placement (2)", description: """
  The below preview shows an embedded placement without brand logos displayed. You can progress through the offers by clicking “Yes Please” or “No Thanks”.
  \n
  The placement UI can be customised to match your app, and create a native experience. This includes changing fonts, colours and multiple configurable options to alter the look and feel of the placement.

  """, viewName: "testiOS", placeholderName: "Location1", type: "embedded", attributes: ["firstname":"danial", "lastname":"m",  "email":"something@example.com", "sandbox":"true", "country":"AU"]),
                                                                ScreenModel(title: "Overlay Placement", description: """
  Click “View Example” to preview a Rokt overlay placement. You can progress through the offers by clicking “Yes Please” or “No Thanks”.\n

  On iOS devices, the overlay placement follows Apple’s best practice automatic presentation style for overlays.\n

  On Android devices, the overlay placements can be configured as a “full-screen overlay” or a “lightbox overlay” with a transparent background.

  """, viewName: "tesLightboxiOS", placeholderName: "Location1", type: "overlay", attributes: ["firstname":"danial", "lastname":"m",  "email":"something@example.com", "sandbox":"true", "country":"AU"])]),
                             customConfigurationPage:
                                CustomConfigurationPageModel(title: "Custom Checkout Flow",
                                                             shortDescription: "View a specific placement or combination of placements on an unbranded confirmation page via a custom checkout flow with configurable options.",
                                                             longDescription: """
The Custom Checkout Flow allows you to preview a specific placement from a specific account in an unbranded confirmation page.
This allows you to preview the specific UI of this placement and experience the in-app behaviour of the Rokt placement.

\n\nNote: In order to preview a specific placement, you will require details about your Rokt account and placement configuration.
If you do not have these, please reach out to your Rokt Account Manager.
""",
                                                             iconURL: "CustomerCheckout",
                                                             accountDetails:
                                                                AccountDetailsModel(accountID: "2754655826098840951",
                                                                                     viewName: "tesLightboxiOS",
                                                                                     placementLocation1: "",
                                                                                     placementLocation2: ""),customerDetails: CustomerDetailsModel(state: "NSW", postcode: "2000", country: ["US","AU","UK","SG"]), advancedDetails: ["experience":"true","majorCat":"true"]),
                             preDefinedScreen1:
                                PreDefinedScreen1Model(title: "Confirmation Page",
                                                       shortDescription: "View a demonstration of how Groupon has integrated in-app Rokt technology into their post-purchase confirmation page. ",
                                                       longDescription: "",
                                                       iconURL: "GrouponLogo"),
                             preDefinedScreen2:
                                PreDefinedScreen2Model(title: "Confirmation Page",
                                                       shortDescription: "View a demonstration of how Stubhub has integrated in-app Rokt technology into their post-purchase confirmation page.",
                                                       longDescription: "",
                                                       iconURL: "StubhubLogo"),
                             preDefinedScreen3:
                                PreDefinedScreen3Model(title: "Confirmation Page",
                                                       shortDescription: "View a demonstration of how Gumtree has integrated in-app Rokt technology into their post-listing confirmation page.",
                                                       longDescription: "",
                                                       iconURL: "GumtreeLogo"))
        
    }
}
