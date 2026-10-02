//
//  AboutRoktService.swift
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

struct AboutRoktService {
    static func getData() -> Future<AboutRoktModel, Error> {
        return Future({ promise in
            do {
                let data = Data(payload.utf8)
                let value = try JSONDecoder().decode(AboutRoktModel.self, from: data)
                promise(.success(value))
            } catch {
                promise(.failure(error))
            }
        })
    }

    /// Content previously served by the demo app server.
    private static let payload = #"""
        {
          "contents": [
            {
              "imageUrl": "",
              "title": "What is the Rokt App?",
              "content": "The Rokt App empowers users to directly experience the mobile SDKs integration on their own devices, by showcasing the functionality that Rokt provides in app.\nThrough the In-app placements, users can explore the different placements that Rokt can power, using real third-party offers from Rokt’s premium advertisers. \nCurrent clients can also input their account details through the Custom placement builder to generate a preview of an in-app placement (in the style of their choice) for their specific account. \nAny examples used are for demonstration purposes only and may not be true reflections of the partner’s application. This app does not collect or store any personal or device data, including any data that the user provides in the Rokt App."
            },
            {
              "imageUrl": "https://apps.rokt.com/store/mobile/img/aboutrokt1.png",
              "title": "About Rokt",
              "content": "Rokt is the global leader in ecommerce technology, powering the Transaction Moment of best-in-class companies. Rokt’s mission: to make ecommerce smarter, faster, and better.\nThrough its proprietary technology, Rokt enables its ecommerce clients to increase brand engagement and unlock new revenues in the Transaction Moment, allowing them to stay ahead of their competition while delivering a relevant and personalized experience for each customer.\nFounded in Sydney, the company now operates in the US, Canada, the UK, Ireland, France, Germany, the Netherlands, Denmark, Sweden, Norway, Finland, Spain, Australia, New Zealand, Singapore, and Japan."
            }
          ],
          "links": [
            {
              "text": "Learn more",
              "url": "https://rokt.com/"
            }
          ]
        }
        """#
}
