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
import Alamofire

struct AboutRoktService {
    static func getData() -> Future<AboutRoktModel, Error> {
        let url = Constants.Urls.base + Constants.Urls.about
        return NetworkService.request(
            url: url,
            method: HTTPMethod.get
        )
    }
    
    static func getData2() -> Future<AboutRoktContentModel?, Error> {
        let url = Constants.Urls.base + "library"
        return NetworkService.request(
                    url: url,
                    method: HTTPMethod.post
                )
            }
    
    
    static func getDemoAboutRokt() -> AboutRoktModel {
        let contents: [AboutRoktContentModel] = [
            AboutRoktContentModel(imageUrl: "",
                                  title: "What is the Rokt Demo app?",
                                  content: """
                Discover why Rokt is the easiest and most powerful way to optimize value across both your customer engagement and revenue objectives.

                The purpose of this app is to showcase the functionality that Rokt provides in-app. This is demonstrated with examples of how Rokt’s partners are generating stronger revenue outcomes by providing a more personalized experience for each customer at scale.

                These examples are used to show Rokt’s capabilities, are for demonstration purposes only, and may not be true reflections of the partners applications. This app does not collect personal or device identifiers.
                """),
            AboutRoktContentModel(imageUrl: "https://apps.rokt.com/store/mobile/img/aboutrokt1.png",
                                  title: "Who we are",
                                  content: """
                Rokt is the global leader in e-commerce technology, powering the Transaction Moment™ of best-in-class companies including Live Nation, Groupon, Staples, Lands' End, Fanatics, GoDaddy, Vistaprint, and HelloFresh. Rokt's mission: To make e-commerce smarter, faster, and better.

                Through its proprietary technology, Rokt enables its e-commerce clients to increase brand engagement and unlock new revenues in the Transaction Moment™, allowing them to stay ahead of their competition while delivering a superior and individualized experience for each customer.

                Founded in Sydney, the company now operates in the US, Canada, the UK, Ireland, France, Germany, the Netherlands, Denmark, Sweden, Norway, Finland, Spain, Australia, New Zealand, Singapore, and Japan.
                """)
        ]
        
        let links: [AboutRoktLinkModel] = [AboutRoktLinkModel(text: "Learn More", url: "https://www.rokt.com")]
 
        
        return AboutRoktModel(contents: contents, links: links)
    }
}
