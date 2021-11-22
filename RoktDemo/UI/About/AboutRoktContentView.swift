//
//  AboutRoktContentView.swift
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
import SDWebImageSwiftUI

struct AboutRoktContentView: View {
    let content: AboutRoktContentModel
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if content.imageUrl != "" {
                WebImage(url: URL(string: content.imageUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            HeaderView(title: content.title)
            DetailTextView(text: content.content)
        }.padding()
    }
}


struct AboutRoktContentView_Previews: PreviewProvider {
    static var previews: some View {
        AboutRoktContentView(content: AboutRoktContentModel(imageUrl: "", title: "Who we are", content: "Rokt is the global leader in e-commerce technology"))
    }
}
