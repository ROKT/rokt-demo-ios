//
//  DemoLibraryViewModel.swift
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

import Foundation

class DemoLibraryViewModel: ObservableObject {
    @Published private(set) var demoItems: [DemoItemModel] = []
    @Published private(set) var demoTitle: String = ""
    @Published private(set) var demoDescription: String = ""
    
    func loadDemoItems() {
        let demo = DemoLibraryService.getDemoLibrary()
        demoTitle = demo.demoTitle
        demoItems = []
        demoDescription = demo.demoDescription
        demoItems.append(demo.defaultPlacementsExamples)
        demoItems.append(demo.customConfigurationPage)
//        demoItems.append(demo.preDefinedScreen1)
//        demoItems.append(demo.preDefinedScreen2)
//        demoItems.append(demo.preDefinedScreen3)
    }
}
