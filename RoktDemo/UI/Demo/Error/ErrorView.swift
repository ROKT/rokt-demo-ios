//
//  ErrorView.swift
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
import Alamofire

struct ErrorView: View {
    let viewModel: ErrorViewModel
    var body: some View {
        ZStack {
            Color.white
            Image("RoktBackgroundLogo")
                .resizable()
                .scaledToFit()
            VStack {
                Image("warning")
                if viewModel.getErrorMessageType() == .network {
                    Text("No network connection. Please try again later once connected.")
                        .font(.defaultHeadingFont(.header1))
                } else {
                    Text("Our systems aren't responding right now.")
                        .font(.defaultHeadingFont(.header1))
                    Text("Please close the app and try again. If the issue persists please contact us at www.rokt.com or try again later.")
                        .font(.defaultFont(.text))
                        .padding(.top)
                }
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(viewModel: ErrorViewModel(error: nil))
    }
}
