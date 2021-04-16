//
//  DefaultPlacementExamplesModel.swift
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

class DefaultPlacementExamplesModel: DemoItemModel {
    var tagID: String
    var screens: [ScreenModel]
    
    required init(title: String,
         shortDescription: String,
         longDescription: String,
         iconURL: String,
         tagID: String,
         screens: [ScreenModel]) {
        self.tagID = tagID
        self.screens = screens
        super.init(title: title,
                   shortDescription: shortDescription,
                   longDescription: longDescription,
                   iconURL: iconURL)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
