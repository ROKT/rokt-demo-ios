//
//  SettingView.swift
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
import Rokt_Widget

@available(iOS 14.0, *)
struct SettingView: View {
    
    @AppStorage(Constants.UserDefaults.useStageEnvironment)
    private var useStage = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HeaderView(title: "Settings")
                Toggle("Stage Environment", isOn: $useStage)
                    .foregroundColor(.black)
            }.frame(maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading)
            .padding()
        }.background(Color.gray3)
            .edgesIgnoringSafeArea([.bottom])
            .modifier(NavigationBarGray(title: ""))
            .onChange(of: useStage){ useStage in
                Rokt.setEnvironment(environment: useStage ? .Stage : .Prod)
            }
    }
}
