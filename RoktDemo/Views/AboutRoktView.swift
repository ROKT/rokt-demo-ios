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
    init() {
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor(named: "AccentColor")
    }
    let model = AboutRoktService.getAboutRokt()
    
    var body: some View {
        ScrollView {
            VStack {
                StickyHeader {
                    ZStack {
                        Image("AboutBackground")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        Text("About Rokt")
                            .foregroundColor(.white)
                            .font(.defaultHeadingFont(.header2))
                    }
                }.padding(.bottom)
                
                ForEach(model.contents, id: \.self) { content in
                    AboutRoktContentView(content: content)
                }
                
                ForEach(model.links, id: \.self) { link in
                    AboutRoktLinkView(link: link)
                }
                
            }
        }
        .edgesIgnoringSafeArea([.top])
    }
}

struct AboutRoktView_Previews: PreviewProvider {
    static var previews: some View {
        AboutRoktView()
    }
}
