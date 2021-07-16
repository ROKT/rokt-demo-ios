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
import Alamofire
import Combine

struct DemoLibraryService {
    static func getData() -> Future<DemoLibraryModel, Error> {
        let url = Constants.Urls.base + Constants.Urls.library
        return NetworkService.request(
            url: url,
            method: HTTPMethod.post
        )
    }
}
