//
//  FeatureWalkthroughViewModel.swift
//  RoktDemo
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import Foundation
struct FeatureWalkthroughViewModel {
    let model: DefaultPlacementExamplesModel
    let selectedScreen: Int
    var screen: ScreenModel { model.screens[selectedScreen]}
    
    func isLastScreen() -> Bool {
        return selectedScreen + 1 == model.screens.count
    }
    
    func getNavigationButtonText() -> String {
        if isLastScreen() {
            return "QUIT DEMO"
        }
        return "NEXT"
    }
    
    func getNavigationTitle() -> String {
        return "\(selectedScreen + 1)/\(model.screens.count)"
    }
}
