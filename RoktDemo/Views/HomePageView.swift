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
    @State var showSafari = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                ZStack {
                    Image("RoktBackgroundLogo")
                        .resizable()
                    VStack {
                        Image("RoktLogo")
                        Text("Powering the Transaction Moment™")
                            .font(.defaultFont(.header3))
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
                Spacer()
                VStack(spacing: 15) {
                    Button(action: {}, label: {
                        Text("Demo Library")
                    })
                    .buttonStyle(ButtonDefaultOutlined())
                    
                    NavigationLink(
                        destination: AboutRoktView(),
                        label: {
                            Text("About Rokt")
                        })
                        .buttonStyle(ButtonDefault())
                        .navigationBarHidden(true)
                        .navigationBarTitle(Text("Home"))
                    
                    Button(action: {
                        self.showSafari = true
                    }) {
                        Text("Contact Us")
                    }
                    .buttonStyle(ButtonDefault())
                    .sheet(isPresented: $showSafari) {
                        SafariView(url:URL(string: Constants.Urls.ContactUS)!)
                    }
                    
                    Text("® Rokt 2021 — All rights reserved App Version 1.0.0")
                        .font(.defaultFont(.subtitle))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                }.padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
