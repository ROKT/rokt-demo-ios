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
                VStack {
                    HStack {
                        Image("RokLaunchLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 76, height: 64, alignment: .center)
                        Image("RoktLogo")
                    }
                    Text("Powering the Transaction Moment™")
                        .font(.defaultFont(.header3))
                        .foregroundColor(.titleColor)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                Spacer()
                VStack(spacing: 15) {
                    NavigationLink(
                        destination: DemoLibraryView(viewModel: DemoLibraryViewModel()),
                        label: {
                            Text("Demo library")
                        })
                        .buttonStyle(ButtonDefaultOutlined())
                        .navigationBarTitle(Text(""))
                    
                    NavigationLink(
                        destination: AboutRoktView(viewModel: AboutRoktViewModel()),
                        label: {
                            Text("About this app")
                        })
                        .buttonStyle(ButtonDefault())
                        .navigationBarTitle(Text(""))
                    
                    Button(action: {
                        self.showSafari = true
                    }) {
                        Text("Contact us")
                    }
                    .buttonStyle(ButtonDefault())
                    .sheet(isPresented: $showSafari) {
                        SafariView(url:URL(string: Constants.Urls.contactUs)!)
                    }
                    
                    Text("® Rokt 2021 — All rights reserved App Version \(UIApplication.appVersion ?? "")")
                        .font(.defaultFont(.subtitle2))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.textColor)
                }.padding()
            }.background(Color.white)
        }.background(Color.white).navigationViewStyle(StackNavigationViewStyle())
        .modifier(NavigationBarTransparent(title: ""))
        .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
