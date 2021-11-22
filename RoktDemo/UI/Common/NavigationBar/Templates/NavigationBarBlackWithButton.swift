//
//  NavigationBarBlackWithButton.swift
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

struct NavigationBarBlackWithButton: ViewModifier {
    var title: String
    var trailingButtonTitle: String
    var trailingButtonAction: () -> Void
    
    func body(content: Content) -> some View {
        content
            .navigationBarColor(.titleColor)
            .navigationBarTitle(Text(title), displayMode: .inline)
            .navigationBarHidden(false)
            .background(NavigationBarAccessor { navigationBar in
                navigationBar.tintColor = .white
            })
            .navigationBarItems(trailing: Button(action: trailingButtonAction, label: {
                Text(trailingButtonTitle)
            }))
    }
}

