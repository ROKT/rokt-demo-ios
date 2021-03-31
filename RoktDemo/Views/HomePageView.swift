//
//  ContentView.swift
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

struct HomePageView: View {
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Image("RoktBackgroundLogo")
                    .resizable()
                VStack {
                    Image("RoktLogo")
                    Text("Powering the Transaction Moment™")
                        .font(.defaultFont(.header))
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
            Spacer()
            VStack(spacing: 15) {
                ButtonDefaultOutlined(text: "Demo Library") {}
                ButtonDefault(text: "About Rokt") {}
                ButtonDefault(text: "Contact Us") {}
                Text("® Rokt 2021 — All rights reserved App Version 1.0.0")
                    .font(.defaultFont(.subtitle))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
            }.padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
