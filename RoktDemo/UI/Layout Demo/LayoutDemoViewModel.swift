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
        attributes["rokt.language"] = preview.language
        
        var slots: [[String: String]] = []
        let layoutVariantCount = preview.layoutVariantIds.count
        
        for (index, creativeId) in preview.creativeIds.enumerated() {
            let layoutVariantId = preview.layoutVariantIds[index % layoutVariantCount]
            let slot: [String: String] = [
                "layoutVariantId": layoutVariantId,
                "creativeId": creativeId
            ]
            slots.append(slot)
        }
        
        let demoConfig = [
            "layouts": [
                [
                    "layoutId": preview.previewId,
                    "versionId": preview.versionId,
                    "slots": slots
                ]
            ]
        ]
        
        if let demoConfigJson = try? JSONSerialization.data(withJSONObject: demoConfig, options: []),
           let demoConfigJsonString = String(data: demoConfigJson, encoding: .utf8) {
            attributes["demoConfig"] = demoConfigJsonString
        }
        
        return attributes
    }
}
