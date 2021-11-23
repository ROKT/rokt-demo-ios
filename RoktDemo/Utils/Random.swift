//
//  Random.swift
//  RoktDemo
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import Foundation
struct Random {
    static func randomiseEmail(email: String?) -> String {
        var randomEmail = email ?? "john.smith@example.com"
        
        if let index = randomEmail.lastIndex(of: "@") {
            let emailId = randomEmail[..<index]
            let domain = randomEmail[index...]
            
            randomEmail = emailId + getFormattedDate() + getRandomNumber() + domain
        }
        return randomEmail
    }
    
    private static func getFormattedDate(_ date: Date = Date()) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYYMMDDHHmmSSS"
        
        return dateFormatter.string(from: date)
    }
    
    private static func getRandomNumber() -> String {
        return "\(Int.random(in: 0..<10000))"
    }
}
