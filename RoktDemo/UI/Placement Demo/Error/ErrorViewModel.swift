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
    case barcode
}

struct ErrorViewModel {
    let error: AFError?
    let barcodeErrorMessage: String?
    
    func getErrorMessageType() -> ErrorMessageType {
        if let error = error {
            if error.isResponseSerializationError {
                return .general
            }
            return .network
        }
        if barcodeErrorMessage != nil {
            return .barcode
        }
        return .general
    }
}



