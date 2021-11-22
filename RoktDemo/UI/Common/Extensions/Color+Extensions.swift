//
//  Color+Extensions.swift
//  RoktDemo
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import SwiftUI
extension Color {
    static let appColor = Color("AccentColor")
    static let gray3 = Color("Gray3")
    static let gray4 = Color("Gray4")
    static let gray9 = Color("Gray9")
    static let titleColor = Color("Gray12")
    static let subtitleColor = Color("Gray7")
    static let textColor = Color("Gray9")
    static let borderColor = Color("Border")
    static let errorColor = Color("Volcano")
}

extension UIColor {
    static let gray3 = UIColor(named: "Gray3")
    static let titleColor = UIColor(named: "Gray12")
}
