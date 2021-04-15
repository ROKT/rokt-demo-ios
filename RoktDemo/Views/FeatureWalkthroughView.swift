//
//  FeatureWalkthroughView.swift
//  RoktDemo
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import SwiftUI
import UIKit
import Rokt_Widget

struct FeatureWalkthroughView: View {
    
    @State var isDisclaimerShown = false
    @State var message = ""

    
    let model: DefaultPlacementExamplesModel
    var body: some View {
        ZStack {
            
            VStack {
                VStack(alignment: .center){
                    Image(model.iconURL)
                        .background(Color.black)
                        .foregroundColor(Color.white)
                        .padding()
                    
                    Text(model.title)
                        .foregroundColor(.white)
                        .font(.defaultHeadingFont(.header1))
                }
                .frame(minWidth: 0,
                       idealWidth: .infinity,
                       maxWidth: .infinity,
                       minHeight: 0,
                       idealHeight: 200,
                       maxHeight: 200,
                       alignment: .center)
                .padding()
                .background(Color.black)
                
                Spacer()
                ScrollView{
                    VStack {
                        Text(model.longDescription)
                            .lineLimit(.none)
                            .font(.defaultFont(.text))
                            .padding()
                    }
                }
                Spacer()
                Button(action: {
                    message = AlertView.template2
                    isDisclaimerShown.toggle()
                }, label: {
                    Text("Let's begin")
                })
                .padding()
                .buttonStyle(ButtonDefaultOutlined())
                
            }.opacity(isDisclaimerShown ? 0 : 1)
            .padding(.bottom, 20)

            EmptyView()
                .background(Color.black)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            
            if isDisclaimerShown {
                AlertView(shown: $isDisclaimerShown, message: message) {
                    
                }
            }
        }
        .background(isDisclaimerShown ? Color.black : Color.white)
        .edgesIgnoringSafeArea([.bottom])
        .modifier(NavigationBarBlack(title: ""))
        
    }
}

struct FeatureWalkthroughView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureWalkthroughView(model: DefaultPlacementExamplesModel(title: "Feature Walkthrough", shortDescription: "", longDescription: "The in-app feature walkthrough highlights the various placement and offer types that are available to native app integrations. \n\nThis includes overlay and embedded placements as well as email, traffic, phone, and app install offers.", iconURL: "FeatureWalkthrough"))
    }
}


