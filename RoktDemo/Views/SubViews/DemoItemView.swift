//
//  DemoItemView.swift
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
import Kingfisher

struct DemoItemView: View {
    let demoItemModel: DemoItemModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack{
                if demoItemModel.iconURL.isUrl() {
                    KFImage.url(
                        URL(string: demoItemModel.iconURL)
                    )
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 60, alignment: .leading)
                } else if !demoItemModel.iconURL.isEmpty {
                    Image(demoItemModel.iconURL)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 60, alignment: .leading)
                        .foregroundColor(.titleColor)
                }
                Spacer()
                Image(systemName: "arrow.right")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.appColor)
            }
            
            Text(demoItemModel.title)
                .font(.defaultBoldFont(.title))
                .foregroundColor(.titleColor)
            Text(demoItemModel.shortDescription).font(.defaultFont(.text))
                .lineLimit(nil)
                .foregroundColor(.textColor)
        }
        .padding([.top, .bottom, .leading], 15)
        .background(Color.white)
    }
}

struct DemoItemView_Previews: PreviewProvider {
    static var previews: some View {
        DemoItemView(demoItemModel: DemoItemModel(title: "title", shortDescription: "short description", longDescription: "", iconURL: "FeatureWalkthrough"))
    }
}
