//
//  AboutRoktView.swift
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

struct AboutRoktView: View {
    let model = AboutRoktService.getAboutRokt()
    
    @State var showSafari = false
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    Image("AboutBackground")
                        .resizable()
                    Text("About Rokt")
                        .foregroundColor(.white)
                        .font(.defaultBoldFont(size: 36))
                }
                
                ForEach(model.contents, id: \.self) { content in
                    AboutRoktContentView(content: content)
                }
                
                ForEach(model.links, id: \.self) { link in
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
                Spacer()
            }
        }
    }
}

struct AboutRoktView_Previews: PreviewProvider {
    static var previews: some View {
        AboutRoktView()
    }
}
