//
//  DetailedText.swift
//  RoktDemo
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import SwiftUI

struct DetailText: View {
    let text: String
    var font: Font = .defaultFont(.text)
    var body: some View {
        Text(text)
            .font(font)
            .foregroundColor(.textColor)
            .lineSpacing(Constants.lineHeight)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct DetailedText_Previews: PreviewProvider {
    static var previews: some View {
        DetailText(text: "text")
    }
}
