//
//  FeatureWalkthroughViewModel.swift
//  RoktDemo
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import Foundation

struct FeatureWalkthroughViewModel {
    let model: DefaultPlacementExamplesModel
    let selectedScreen: Int
    var screen: ScreenModel { model.screens[selectedScreen]}
    
    func isLastScreen() -> Bool {
        return selectedScreen + 1 == model.screens.count
    }
    
    func getNavigationButtonText() -> String {
        if isLastScreen() {
            return "QUIT DEMO"
        }
        return "NEXT"
    }
    
    func getNavigationTitle() -> String {
        return "\(selectedScreen + 1)/\(model.screens.count)"
    }
    
    func getAttributes() -> [String: String] {
        var attributes = screen.attributes
        let email = attributes["email"]
        attributes["email"] = randomiseEmail(email: email)
        
        return attributes
    }
    
    func randomiseEmail(email: String?) -> String {
        var randomEmail = email ?? "john.smith@example.com"
        
        if let index = randomEmail.lastIndex(of: "@") {
            let emailId = randomEmail[..<index]
            let domain = randomEmail[index...]
            
            randomEmail = emailId + getFormattedDate() + getRandomNumber() + domain
        }
        return randomEmail
    }
    
    func getFormattedDate(_ date: Date = Date()) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "YYYYMMDDHHmmSSS"
        
        return dateFormatter.string(from: date)
    }
    
    func getRandomNumber() -> String {
        return "\(Int.random(in: 0..<10000))"
    }

}
