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
    
    @ObservedObject var viewModel: AboutRoktViewModel
    
    var body: some View {
        ZStack {
            switch viewModel.uiState {
            case .loading:
                ActivityIndicator()
                    .frame(width: 100, height: 100, alignment: .center)
            case .error(let error):
                ErrorView(viewModel: ErrorViewModel(error: error)).modifier(NavigationBarGray(title: ""))
            default:
                
                ScrollView {
                    
                    VStack {
                        ExtendableHeader {
                            ZStack {
                                Image("AboutBackground")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                Text("About Rokt")
                                    .foregroundColor(.white)
                                    .font(.defaultHeadingFont(.header2))
                            }
                        }.padding(.bottom)
                    }
                    
                    ForEach(viewModel.aboutModel.contents, id: \.self) { content in
                        AboutRoktContentView(content: content)
                    }
                    
                    ForEach(viewModel.aboutModel.links, id: \.self) { link in
                        AboutRoktLinkView(link: link)
                    }
                    
                }.modifier(NavigationBarTransparent(title: ""))
            }
            
        }
        .onAppear {
            viewModel.loadAboutRokt()
        }
        .edgesIgnoringSafeArea([.top])
        .modifier(NavigationBarTransparent(title: ""))
    }
}

struct AboutRoktView_Previews: PreviewProvider {
    static var previews: some View {
        AboutRoktView(viewModel: AboutRoktViewModel())
    }
}
