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
import Combine

struct DemoLibraryService {
    static func getData() -> Future<DemoLibraryModel, Error> {
        return Future({ promise in
            do {
                let data = Data(payload.utf8)
                let value = try JSONDecoder().decode(DemoLibraryModel.self, from: data)
                promise(.success(value))
            } catch {
                promise(.failure(error))
            }
        })
    }

    /// Content previously served by the demo app server.
    private static let payload = #"""
        {
          "demoTitle": "Placement library",
          "demoDescription": "Unlock the hidden potential in every single transaction. Using award-winning machine learning algorithms, you can power stronger revenue outcomes and optimize the transaction experience for each customer, at scale.",
          "defaultPlacementsExamples": {
            "title": "In-app placements",
            "shortDescription": "View examples of different placement experiences—with live offers from our premium advertisers.",
            "longDescription": "For prospects and current clients\n\nIn this interactive demonstration, we’ll guide you through the different placement styles that are available for the mobile SDKs.\n\nYou’ll learn about our embedded and overlay placements, as well as the types of offers we support, including email, traffic, phone, and app install.\n",
            "iconURL": "FeatureWalkthrough",
            "tagID": "2920840145279427107",
            "screens": [
              {
                "title": "Embedded placement",
                "description": "In this example, you see an embedded placement without brand logos.\n\nUsers can interact with the placement to view multiple offers including traffic, email, phone, and app install campaigns.\n\nEmbedded placements sit within existing content, with customizable fonts, colors, and more to create a native app experience.\n",
                "viewName": "FeatureWalkthroughEmbedded1",
                "placeholderName": "RoktEmbedded1",
                "type": "Embedded",
                "attributes": {
                  "name": "John",
                  "lastname": "Smith",
                  "email": "john.smith@example.com",
                  "sandbox": "true",
                  "country": "US"
                }
              },
              {
                "title": "Embedded placement",
                "description": "In this example, you see an embedded placement with brand logos.\n",
                "viewName": "FeatureWalkthroughEmbedded2",
                "placeholderName": "RoktEmbedded1",
                "type": "Embedded",
                "attributes": {
                  "name": "Jane",
                  "lastname": "Smith",
                  "email": "jane.smith@example.com",
                  "sandbox": "true",
                  "country": "US"
                }
              },
              {
                "title": "Overlay placement",
                "description": "Tap “View example” to preview a fullscreen overlay placement, which is the standard style for iOS devices. For other devices, the standard style would be a lightbox overlay, where the placement shows over a translucent grey background. Overlay placements are always dynamic to the user’s device.\n",
                "viewName": "FeatureWalkthroughOverlay",
                "placeholderName": "RoktEmbedded1",
                "type": "Overlay",
                "attributes": {
                  "name": "John",
                  "lastname": "Doe",
                  "email": "john.doe@example.com",
                  "sandbox": "true",
                  "country": "US"
                }
              }
            ]
          },
          "customConfigurationPage": {
            "title": "Custom placement builder",
            "shortDescription": "Enter your Rokt account details to see an example of how your custom placement would appear on a sample in-app confirmation page.",
            "longDescription": "For current clients\n\nWith the placement builder, you can preview one of your account’s configured placements on a sample in-app confirmation page. You can experience the look and feel of the placement in the same way customers would.\n\nNote: In order to preview a specific placement, your Rokt account and placement configuration details are required. If you do not have these, reach out to your account manager.\n",
            "iconURL": "CustomerCheckout",
            "accountDetails": {
              "accountID": "2920840145279427107",
              "viewName": "RoktExperience",
              "placementLocation1": "RoktEmbedded1",
              "placementLocation2": "RoktEmbedded2"
            },
            "customerDetails": {
              "country": [
                "US",
                "AU",
                "UK",
                "SG",
                "IE",
                "NL",
                "DE",
                "FR",
                "JP",
                "ES",
                "FI",
                "NO",
                "SE",
                "DK",
                "CA",
                "IN"
              ],
              "state": "New York",
              "postcode": "10001"
            },
            "advancedDetails": {
              "firstName": "John",
              "lastName": "Smith",
              "email": "john.smith@example.com",
              "experience": "true",
              "sandbox": "true"
            }
          },
          "preDefinedScreen1": {
            "title": "Confirmation Page",
            "shortDescription": "View a demonstration of how Heated has integrated in-app Rokt technology into their post-purchase confirmation page.",
            "iconURL": "HeatedLogo",
            "descriptions": [
              {
                "title": "Vertical",
                "text": "Retail - Deals and Group Buying",
                "iconURL": "VerticalIcon"
              },
              {
                "title": "Marketing Objectives",
                "text": "Customer LTV, Additional profit",
                "iconURL": "MarketingIcon"
              },
              {
                "title": "Solutions",
                "text": "Rokt Ecommerce (Internal campaigns, Marketplace)",
                "iconURL": "SolutionsIcon"
              },
              {
                "title": "Placement Type",
                "text": "Embedded - Standard",
                "iconURL": "PlacementTypeIcon"
              }
            ],
            "isBranded": false,
            "tagID": "2920840145279427107",
            "viewName": "groupon",
            "placeholderName": "RoktEmbedded1",
            "type": "embedded",
            "attributes": {
              "first": "John",
              "email": "john.smith@example.com",
              "lastname": "Smith",
              "sandbox": "true",
              "country": "US"
            }
          },
          "preDefinedScreen2": {
            "title": "Confirmation Page",
            "shortDescription": "View a demonstration of how Stylus Commerce has integrated in-app Rokt technology into their post-purchase confirmation page.",
            "iconURL": "StylusCommerceLogo",
            "descriptions": [
              {
                "title": "Vertical",
                "text": "Ticketing - Events",
                "iconURL": "VerticalIcon"
              },
              {
                "title": "Marketing Objectives",
                "text": "Additional profit",
                "iconURL": "MarketingIcon"
              },
              {
                "title": "Solutions",
                "text": "Rokt Marketplace",
                "iconURL": "SolutionsIcon"
              },
              {
                "title": "Placement Type",
                "text": "Overlay - Standard",
                "iconURL": "PlacementTypeIcon"
              }
            ],
            "isBranded": false,
            "tagID": "2920840145279427107",
            "viewName": "stubhub",
            "placeholderName": "RoktEmbedded1",
            "type": "overlay",
            "attributes": {
              "first": "John",
              "email": "john.smith@example.com",
              "lastname": "Smith",
              "sandbox": "true",
              "country": "US"
            }
          },
          "preDefinedScreen3": {
            "title": "Post Listing Page",
            "shortDescription": "View a demonstration of how Waveroom Supply Co has integrated in-app Rokt technology into their post-listing confirmation page.",
            "iconURL": "WaveroomSupplyLogo",
            "descriptions": [
              {
                "title": "Vertical",
                "text": "Media and Entertainment - Classifields",
                "iconURL": "VerticalIcon"
              },
              {
                "title": "Marketing Objectives",
                "text": "Ancillary Revenue",
                "iconURL": "MarketingIcon"
              },
              {
                "title": "Solutions",
                "text": "Rokt Marketplace",
                "iconURL": "SolutionsIcon"
              },
              {
                "title": "Placement Type",
                "text": "Standard - Embedded",
                "iconURL": "PlacementTypeIcon"
              }
            ],
            "isBranded": false,
            "tagID": "2920840145279427107",
            "viewName": "gumtree",
            "placeholderName": "RoktEmbedded1",
            "type": "embedded",
            "attributes": {
              "first": "John",
              "email": "john.smith@example.com",
              "lastname": "Smith",
              "sandbox": "true",
              "country": "US"
            }
          }
        }
        """#
}
