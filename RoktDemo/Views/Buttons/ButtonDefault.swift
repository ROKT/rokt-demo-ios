//
//  ButtonDefault.swift
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

struct ButtonDefault: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding()
            .font(.defaultButtonFont())
            .frame(maxWidth: .infinity)
            .foregroundColor(Color.accentColor)
            .border(Color.accentColor, width: 2)
    }
}
