//
//  LayoutDemoUIState.swift
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

enum LayoutDemoUIState: Equatable {
    static func == (lhs: LayoutDemoUIState, rhs: LayoutDemoUIState) -> Bool {
        switch (lhs, rhs) {
        case(.loading, .loading):
            return true
        case (.hasData, .hasData):
            return true
        case (.error(let lError), .error(error: let rError)):
            return lError == rError
        case (.initiated, .initiated):
            return true
        case (.done, .done):
            return true
        default:
            return false
        }
    }
    
    case initiated
    case loading
    case error(error: String)
    case hasData
    case done
}
