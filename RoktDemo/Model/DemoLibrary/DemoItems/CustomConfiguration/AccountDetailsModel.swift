//
//  CustomerDetailsModel.swift
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
struct AccountDetailsModel: Codable {
    var accountID: String
    var viewName: String
    var placementLocation1: String
    var placementLocation2: String
}
