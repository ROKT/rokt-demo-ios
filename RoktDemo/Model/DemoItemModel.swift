//
//  DemoItemModel.swift
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

class DemoItemModel: Codable {
    var title: String
    var shortDescription: String
    var longDescription: String
    var iconURL: String
    
    init(title: String,
         shortDescription: String,
         longDescription: String,
         iconURL: String) {
        self.title = title
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.iconURL = iconURL
    }
}
