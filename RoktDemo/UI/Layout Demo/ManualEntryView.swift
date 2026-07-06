//
//  ManualEntryView.swift
//  RoktDemo
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import SwiftUI

struct ManualEntryView: View {
    @ObservedObject var viewModel: LayoutDemoViewModel
    @Binding var isPresented: Bool

    @AppStorage("manualEntry.tagId") private var tagId: String = "343"
    @AppStorage("manualEntry.previewId") private var previewId: String = "3570823419066187777"
    @AppStorage("manualEntry.versionId") private var versionId: String = "1779204183552"
    @AppStorage("manualEntry.creativeIdsText") private var creativeIdsText: String = "3490020616040873984"
    @AppStorage("manualEntry.layoutVariantIdsText") private var layoutVariantIdsText: String = "3588707418073595917"
    @AppStorage("manualEntry.language") private var language: String = "en"
    @AppStorage("manualEntry.catalogItemId") private var catalogItemId: String = "02b4225b-f1b2-470f-8fe6-0fcf980e500c"

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Manual Layout Entry")
                        .font(.defaultBoldFont(.header2))
                        .foregroundColor(.titleColor)

                    Text("Enter the same fields a QR code would carry. Comma-separate IDs that take arrays.")
                        .font(.defaultFont(.subtitle1))
                        .foregroundColor(.subtitleColor)

                    DetailTextFieldView(title: "Tag ID", textHolder: $tagId)
                    DetailTextFieldView(title: "Layout ID", textHolder: $previewId)
                    DetailTextFieldView(title: "Version ID", textHolder: $versionId)
                    DetailTextFieldView(title: "Creative IDs (comma-separated)", textHolder: $creativeIdsText)
                    DetailTextFieldView(title: "Layout Variant IDs (comma-separated)", textHolder: $layoutVariantIdsText)
                    DetailTextFieldView(title: "Language", textHolder: $language)
                    DetailTextFieldView(title: "Catalog Item ID (optional)", textHolder: $catalogItemId)

                    Button(action: render) {
                        Text("Render Layout")
                    }
                    .buttonStyle(ButtonDefault())
                    .padding(.top, 8)
                    .disabled(!canRender)

                    Button(action: { isPresented = false }) {
                        Text("Cancel")
                    }
                    .buttonStyle(ButtonDefaultOutlined())
                }
                .padding()
            }
            .background(Color.gray3)
            .modifier(NavigationBarGray(title: ""))
        }
    }

    private var canRender: Bool {
        !tagId.trimmingCharacters(in: .whitespaces).isEmpty &&
            !previewId.trimmingCharacters(in: .whitespaces).isEmpty &&
            !versionId.trimmingCharacters(in: .whitespaces).isEmpty &&
            !splitCSV(creativeIdsText).isEmpty &&
            !splitCSV(layoutVariantIdsText).isEmpty &&
            !language.trimmingCharacters(in: .whitespaces).isEmpty
    }

    private func buildPreview() -> PreviewData {
        let trimmedCatalogId = catalogItemId.trimmingCharacters(in: .whitespaces)
        return PreviewData(
            tagId: tagId.trimmingCharacters(in: .whitespaces),
            previewId: previewId.trimmingCharacters(in: .whitespaces),
            versionId: versionId.trimmingCharacters(in: .whitespaces),
            creativeIds: splitCSV(creativeIdsText),
            layoutVariantIds: splitCSV(layoutVariantIdsText),
            language: language.trimmingCharacters(in: .whitespaces),
            catalogItemId: trimmedCatalogId.isEmpty ? nil : trimmedCatalogId
        )
    }

    private func render() {
        let preview = buildPreview()

        guard
            let data = try? JSONEncoder().encode(preview),
            let json = String(data: data, encoding: .utf8)
        else {
            viewModel.uiState = .error(error: "Failed to encode manual entry payload")
            return
        }

        isPresented = false
        viewModel.uiState = .loading
        viewModel.parseQRcodeResult(json)
    }

    private func splitCSV(_ text: String) -> [String] {
        text.split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
    }

}
