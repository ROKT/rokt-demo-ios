//
//  LayoutDemoViewModel.swift
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
import Rokt_Widget

class LayoutDemoViewModel: ObservableObject {
    
    @Published var uiState = LayoutDemoUIState.initiated
    var preview: PreviewData? = nil
    
    private var cancellable: AnyCancellable?
    
    func parseQRcodeResult(_ result: String) {
        let decoder = JSONDecoder()
        do {
            guard let data = result.data(using: .utf8, allowLossyConversion: false) else { return }
            let preview = try decoder.decode(PreviewData.self, from: data)
            renderResult(preview: preview)
        } catch {
            self.uiState = .error(error: error.localizedDescription)
        }
    }
    
    private func renderResult(preview: PreviewData) {
        Task {
            if !preview.tagId.isEmpty {
                Rokt.initWith(roktTagId: preview.tagId)
            }
            try await Task.sleep(seconds: 3)
            
            self.preview = preview
            await MainActor.run{
                uiState = .hasData
            }
           
        }
    }
    
    func getAttributes() -> [String: String] {
        guard let preview else { return [:] }
        var attributes = [String: String]()
        attributes["isDemo"] = "true"
        attributes["layoutId"] = preview.previewId
        attributes["versionId"] = preview.versionId
        attributes["creativeId"] = preview.creativeIds.joined(separator: ",")
        return attributes
    }
}
