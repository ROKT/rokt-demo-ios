//
//  RoktEmbeddedSwiftUIView.swift
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

import Rokt_Widget
import SwiftUI

struct RoktEmbeddedSwiftUIView: UIViewRepresentable {
    typealias UIViewType = RoktEmbeddedView
    var embedded: RoktEmbeddedView
    
    init() {
        embedded = RoktEmbeddedView()
    }
    
    func makeUIView(context: Context) -> RoktEmbeddedView {
        return embedded
    }
    
    func updateUIView(_ uiView: RoktEmbeddedView, context: Context) {
        
    }
}
