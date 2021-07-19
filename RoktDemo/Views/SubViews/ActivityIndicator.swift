//
//  ActivityIndicator.swift
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

struct ActivityIndicator: View {

  @State private var isAnimating: Bool = false

  var body: some View {
    GeometryReader { (geometry: GeometryProxy) in
        ForEach(0..<6) { index in
            Group {
                Circle()
                    .frame(width: geometry.size.width / 7, height: geometry.size.height / 7)
                    .scaleEffect(!self.isAnimating ? 1 - CGFloat(index) / 6 : 0.2 + CGFloat(index) / 6)
                    .offset(y: geometry.size.width / 10 - geometry.size.height / 2)
            }.frame(width: geometry.size.width, height: geometry.size.height)
            .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
            .animation(Animation
                        .timingCurve(0.5, 0.15 + Double(index) / 6, 0.25, 1, duration: 2)
                        .repeatForever(autoreverses: false))
        }
    }
    .aspectRatio(1, contentMode: .fit)
    .foregroundColor(.appColor)
    .onAppear {
        self.isAnimating = true
    }
  }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator()
    }
}
