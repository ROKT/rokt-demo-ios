//
//  Font+Extensions.swift
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

extension Font {
    public enum FontSize: CGFloat {
        case title = 22
        case header = 18
        case text = 16
        case subtitle = 12
    }
    
    static func defaultFont(_ fontSize: FontSize) -> Font {
        return defaultFont(size: fontSize.rawValue)
    }
    
    static func defaultButtonFont() -> Font {
        return defaultBoldFont(size: 18)
    }
    
    static func defaultFont(size: CGFloat) -> Font {
        return .custom("Soleil", size: size)
    }
    
    static func defaultBoldFont(size: CGFloat) -> Font {
        return .custom("Soleil-Bold", size: size)
    }
}
