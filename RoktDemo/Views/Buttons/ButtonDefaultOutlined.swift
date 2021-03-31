//
//  ButtonDefaultOutlined.swift
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

struct ButtonDefaultOutlined: View {
    let text: String
    let action: () -> Void
    var body: some View {
        Button(action: action, label: {
            Text(text)
                .padding()
                .font(.defaultButtonFont())
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Color.accentColor)
        })
    }
}

struct ButtonDefaultOutlined_Previews: PreviewProvider {
    static var previews: some View {
        ButtonDefaultOutlined(text: "About Rokt") {
            
        }
    }
}
