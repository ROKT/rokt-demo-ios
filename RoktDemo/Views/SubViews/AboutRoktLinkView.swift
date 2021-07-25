//
//  AboutRoktLinkView.swift
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

struct AboutRoktLinkView: View {
    @State var showSafari = false
    let link : AboutRoktLinkModel
    var body: some View {
        Button(action: {
            self.showSafari = true
        }) {
            Text(link.text)
        }
        .buttonStyle(ButtonDefault())
        .sheet(isPresented: $showSafari) {
            SafariView(url:URL(string: link.url)!)
        }.padding()
    }
}

struct AboutRoktLinkView_Previews: PreviewProvider {
    static var previews: some View {
        AboutRoktLinkView(link:
                            AboutRoktLinkModel(text: "Learn More",
                                               url: "https://www.rokt.com"))
    }
}
