//
//  NavigationBarTransparent.swift
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

struct NavigationBarTransparent: ViewModifier {
    var title: String
    
    func body(content: Content) -> some View {
        content
            .navigationBarColor(.clear)
            .navigationBarTitle(Text(title), displayMode: .inline)
            .navigationBarHidden(false)
            .background(NavigationBarAccessor { navigationBar in
                navigationBar.tintColor = .white
           })
    }
}
