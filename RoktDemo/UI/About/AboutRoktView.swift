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
                ActivityIndicatorView()
                    .frame(width: 100, height: 100, alignment: .center).background(Color.white)
                    .modifier(NavigationBarGray(title: "")).background(Color.white)
            case .error(let error):
                ErrorView(viewModel: ErrorViewModel(error: error)).modifier(NavigationBarGray(title: "")).background(Color.white)
            default:
                
                ScrollView {
                    VStack {
                        ForEach(viewModel.aboutModel.contents, id: \.self) { content in
                            AboutRoktContentView(content: content)
                        }
                    }
                }
            }
            
        }.background(Color.white)
        .onAppear {
            viewModel.loadAboutRokt()
        }
        .modifier(NavigationBarWhite(title: ""))
    }
}

struct AboutRoktView_Previews: PreviewProvider {
    static var previews: some View {
        AboutRoktView(viewModel: AboutRoktViewModel()).preferredColorScheme(.dark)
    }
}
