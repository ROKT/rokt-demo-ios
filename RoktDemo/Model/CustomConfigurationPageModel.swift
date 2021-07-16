//
//  CustomConfigurationPageModel.swift
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

class CustomConfigurationPageModel: DemoItemModel {
    var accountDetails: AccountDetailsModel
    var customerDetails: CustomerDetailsModel
    var advancedDetails: [String: String]
    required init(title: String,
         shortDescription: String,
         longDescription: String?,
         iconURL: String,
         accountDetails: AccountDetailsModel,
         customerDetails: CustomerDetailsModel,
         advancedDetails: [String: String]) {
        self.accountDetails = accountDetails
        self.customerDetails = customerDetails
        self.advancedDetails = advancedDetails
        super.init(title: title,
                   shortDescription: shortDescription,
                   longDescription: longDescription,
                   iconURL: iconURL)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        accountDetails = try values.decode(AccountDetailsModel.self, forKey: .accountDetails)
        customerDetails = try values.decode(CustomerDetailsModel.self, forKey: .customerDetails)
        advancedDetails = try values.decode([String: String].self, forKey: .advancedDetails)
        
        let title = try values.decode(String.self, forKey: .title)
        let shortDescription = try values.decode(String.self, forKey: .shortDescription)
        let longDescription = try values.decode(String.self, forKey: .longDescription)
        let iconURL = try values.decode(String.self, forKey: .iconURL)
        
        super.init(title: title,
                   shortDescription: shortDescription,
                   longDescription: longDescription,
                   iconURL: iconURL)
    }
    
    enum CodingKeys: CodingKey {
      case title, shortDescription, longDescription, iconURL, accountDetails, customerDetails, advancedDetails
    }
}
