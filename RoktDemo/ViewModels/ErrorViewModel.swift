//
//  ErrorViewModel.swift
//  RoktDemo
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import Foundation
import Alamofire

enum ErrorMessageType {
    case network
    case general
}

struct ErrorViewModel {
    let error: AFError?
    
    func getErrorMessageType() -> ErrorMessageType {
        if error != nil && error!.isResponseSerializationError {
            return.general
        }
        return .network
    }
}



