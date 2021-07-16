//
//  AboutRoktViewModel.swift
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
import Combine

class AboutRoktViewModel: ObservableObject {
    @Published private(set) var aboutModel: AboutRoktModel = AboutRoktModel(contents: [], links: [])
    
    @Published private(set) var uiState = UIState.loading

    private var cancellable: AnyCancellable?
    func loadAboutRokt() {
        
        cancellable = AboutRoktService.getData().sink(receiveCompletion: { complition in
            switch complition {
            case .failure(let error):
                print(error)
                self.uiState = .error(error: error.localizedDescription)
            case .finished:
                self.uiState = .hasData
            }
            
        }, receiveValue: { value in
            self.aboutModel = value
        })
    }
    
}
