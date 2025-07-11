//
//  Constants.swift
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


import SwiftUI

struct Constants {
    
    struct Urls {
        static let base = "https://rokt-demo-app-server.rokt.com/"
        static let about = "about"
        static let library = "library"
        static let contactUs = "https://rokt.com/contact-us/"
    }
    
    struct Strings {
        static let exitDemo = "EXIT"
        static let continueDemo = "Continue"
    }
    
    static let lineHeight: CGFloat = 5.0
    
    struct UserDefaults {
        static let useStageEnvironment = "useStageEnvironment"
    }
}
