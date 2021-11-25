//
//  PreDefinedScreen1Model.swift
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

class PreDefinedScreenModel: DemoItemModel {
    let descriptions: [DescriptionItem]
    let tagID: String
    let viewName: String
    let placeholderName: String
    let type: String
    let attributes: [String: String]
    let isBranded: Bool
    
    required init(title: String,
                  shortDescription: String,
                  longDescription: String?,
                  iconURL: String,
                  descriptions: [DescriptionItem],
                  tagID: String,
                  viewName: String,
                  placeholderName: String,
                  type: String,
                  attributes: [String: String],
                  isBranded: Bool) {
        self.descriptions = descriptions
        self.tagID = tagID
        self.viewName = viewName
        self.placeholderName = placeholderName
        self.type = type
        self.attributes = attributes
        self.isBranded = isBranded
        super.init(title: title,
                   shortDescription: shortDescription,
                   longDescription: longDescription,
                   iconURL: iconURL)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        descriptions = try values.decode([DescriptionItem].self, forKey: .descriptions)
        tagID = try values.decode(String.self, forKey: .tagID)
        viewName = try values.decode(String.self , forKey: .viewName)
        placeholderName = try values.decode(String.self, forKey: .placeholderName)
        type = try values.decode(String.self, forKey: .type)
        attributes = try values.decode([String: String].self, forKey: .attributes)
        isBranded = try values.decode(Bool.self, forKey: .isBranded)
        
        let title = try values.decode(String.self, forKey: .title)
        let shortDescription = try values.decode(String.self, forKey: .shortDescription)
        let iconURL = try values.decode(String.self, forKey: .iconURL)
        
        super.init(title: title,
                   shortDescription: shortDescription,
                   longDescription: "",
                   iconURL: iconURL)
    }
    
    enum CodingKeys: CodingKey {
        case title, shortDescription, longDescription, iconURL, descriptions
        case tagID, viewName, placeholderName, type, attributes, isBranded
    }
}
