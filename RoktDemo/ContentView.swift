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

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Image("RoktLogo")
                Text("Powering the Transaction Moment™")
                    .font(.custom("Soleil", size: 18))
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
                VStack {
                    Button(action: {}, label: {
                        Text("Demo Library")
                            .padding()
                            .font(.custom("Soleil-Bold", size: 18))
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                    })
                    Button(action: {}, label: {
                        Text("About Rokt")
                            .font(.custom("Soleil-Bold", size: 18))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .border(Color.accentColor, width: 2)
                    })
                    Button(action: {}, label: {
                        Text("Contact Us")
                            .font(.custom("Soleil-Bold", size: 18))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .border(Color.accentColor, width: 2)
                    })
                    Text("® Rokt 2021 — All rights reserved App Version 1.0.0")
                        .font(.custom("Soleil-Bold", size: 12))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                }.padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
