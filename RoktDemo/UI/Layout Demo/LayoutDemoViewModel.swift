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

    public var cancellable: AnyCancellable?

    func parseQRcodeResult(_ result: String) {
        print("[ViewModel] parseQRcodeResult input bytes=\(result.utf8.count)")
        let decoder = JSONDecoder()
        do {
            guard let data = result.data(using: .utf8, allowLossyConversion: false) else {
                print("[ViewModel] parseQRcodeResult: failed to get UTF-8 data")
                return
            }
            let preview = try decoder.decode(PreviewData.self, from: data)
            print("[ViewModel] parseQRcodeResult: decoded OK, tagId=\(preview.tagId)")
            renderResult(preview: preview)
        } catch {
            print("[ViewModel] parseQRcodeResult: decode FAILED \(error)")
            self.uiState = .error(error: error.localizedDescription)
        }
    }

    private func renderResult(preview: PreviewData) {
        print("[ViewModel] renderResult: spawning Task")
        Task {
            print("[ViewModel] Task: entered. tagId.isEmpty=\(preview.tagId.isEmpty)")
            if !preview.tagId.isEmpty {
                Rokt.initWith(roktTagId: preview.tagId)
            }
            print("[ViewModel] Task: initWith returned, starting 3s sleep")
            do {
                try await Task.sleep(seconds: 3)
            } catch {
                print("[ViewModel] Task: sleep threw \(error) (likely cancelled). isCancelled=\(Task.isCancelled)")
                return
            }
            print("[ViewModel] Task: sleep finished, about to set uiState=.hasData")

            self.preview = preview
            await MainActor.run{
                uiState = .hasData
                print("[ViewModel] Task: uiState set to .hasData on MainActor")
            }
        }
    }

    func getAttributes() -> [String: String] {
        guard let preview else { return [:] }
        var attributes = [String: String]()
        attributes["isDemo"] = "true"
        attributes["upsellsProviderName"] = "canal"
        attributes["firstname"] = "ops"
        attributes["lastname"] = "test"
        attributes["email"] = "jenny.smith@example.com"
        attributes["confirmationref"] = "ORD-12345"
        attributes["billingzipcode"] = "07762"
        if let catalogItemId = preview.catalogItemId, !catalogItemId.isEmpty {
            attributes["catalogItemId"] = catalogItemId
        }

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
