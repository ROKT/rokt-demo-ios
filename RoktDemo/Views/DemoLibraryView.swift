//
//  DemoLibraryView.swift
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

struct DemoLibraryView: View {
    
    @ObservedObject var viewModel: DemoLibraryViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HeaderView(title: viewModel.demoTitle)
                
                Text(viewModel.demoDescription)
                    .font(.defaultFont(.text))
                
                ForEach(viewModel.demoItems, id: \.self) { item in
                    NavigationLink(
                        destination: getDemoItemDestination(item),
                        label: {
                            DemoItemView(demoItemModel: item)
                        })
                    
                }
            }.padding()
        }
        .onAppear {
            viewModel.loadDemoItems()
        }
        .background(Color.gray3)
        .edgesIgnoringSafeArea([.bottom])
        .modifier(NavigationBarGray(title: ""))
    }
    
    @ViewBuilder func getDemoItemDestination(_ model: DemoItemModel) -> some View {
        DemoItemSummaryView(viewModel: DemoItemSummaryViewModel(model))
    }
}

struct DemoLibraryView_Previews: PreviewProvider {
    static var previews: some View {
        DemoLibraryView(viewModel: DemoLibraryViewModel())
    }
}
