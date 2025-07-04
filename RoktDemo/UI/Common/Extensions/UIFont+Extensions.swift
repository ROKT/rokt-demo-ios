//
//  UIFont+Extensions.swift
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

import UIKit

extension UIFont {
    
    static func defaultFont(_ fontSize: FontSize) -> UIFont {
        return defaultFont(size: fontSize.rawValue)
    }
    
    static func defaultButtonFont() -> UIFont {
        return defaultBoldFont(size: 18)
    }
    
    static func defaultHeadingFont(_ fontSize: FontSize) -> UIFont {
        return defaultHeadingFont(size: fontSize.rawValue)
    }
    
    static func defaultBoldFont(_ fontSize: FontSize) -> UIFont {
        return defaultBoldFont(size: fontSize.rawValue)
    }
    
    static func defaultFont(size: CGFloat) -> UIFont {
        return UIFont(name: "Archivo-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func defaultBoldFont(size: CGFloat) -> UIFont {
        return UIFont(name: "Archivo-SemiBold", size: size) ?? .boldSystemFont(ofSize: size)
    }
    
    static func defaultHeadingFont(size: CGFloat) -> UIFont {
        return UIFont(name: "balto-bold", size: size) ?? .boldSystemFont(ofSize: size)
    }
    
    static func arialFont(size: CGFloat, isBold: Bool = false) -> UIFont {
        return UIFont(name: isBold ? "Arial-BoldMT" : "ArialMT", size: size) ?? (isBold ? .boldSystemFont(ofSize: size) : .systemFont(ofSize: size))
    }
    
    static func latoFont(size: CGFloat, isBold: Bool = false) -> UIFont {
        return UIFont(name: isBold ? "Lato-Bold" : "Lato", size: size) ?? (isBold ? .boldSystemFont(ofSize: size) : .systemFont(ofSize: size))
    }
}
