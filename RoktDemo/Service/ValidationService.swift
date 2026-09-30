//
//  ValidationService.swift
//  RoktDemo
//
//  Created by Danial Motahari on 18/5/21.
//

import Foundation
struct ValidationService {
    
    static func isEmpty(_ text: String?) -> Bool {
        return text?.isEmpty ?? true
    }
}
