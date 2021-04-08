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

                                """, iconURL: ""),
                             customConfigurationPage:
                                CustomConfigurationPageModel(title: "Custom Checkout Flow",
                                                             shortDescription: "View a specific placement or combination of placements on an unbranded confirmation page via a custom checkout flow with configurable options.",
                                                             longDescription: "", iconURL: ""),
                             preDefinedScreen1:
                                PreDefinedScreen1Model(title: "Confirmation Page",
                                                       shortDescription: "View a demonstration of how Groupon has integrated in-app Rokt technology into their post-purchase confirmation page. ",
                                                       longDescription: "", iconURL: ""),
                             preDefinedScreen2:
                                PreDefinedScreen2Model(title: "Confirmation Page",
                                                       shortDescription: "View a demonstration of how Stubhub has integrated in-app Rokt technology into their post-purchase confirmation page.",
                                                       longDescription: "", iconURL: ""),
                             preDefinedScreen3:
                                PreDefinedScreen3Model(title: "Confirmation Page",
                                                       shortDescription: "View a demonstration of how Gumtree has integrated in-app Rokt technology into their post-listing confirmation page.",
                                                       longDescription: "", iconURL: ""))
        
    }
}
