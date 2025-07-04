//
//  LayoutDemoUIViewWrapper.swift
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

struct LayoutDemoUIViewWrapper: UIViewControllerRepresentable {
    @EnvironmentObject var appState: AppState
    
    func makeUIViewController(context: Context) -> LayoutDemoUIView {
        let viewModel = LayoutDemoViewModel()
        return LayoutDemoUIView(viewModel: viewModel, appState: appState)
    }
    
    func updateUIViewController(_ uiViewController: LayoutDemoUIView, context: Context) {
        // Update the view controller if needed
    }
}

// Example usage in a SwiftUI view:
struct ExampleView: View {
    var body: some View {
        NavigationView {
            LayoutDemoUIViewWrapper()
                .navigationBarTitle("Layout Demo", displayMode: .inline)
        }
    }
}

// Example of how to use it in a NavigationLink:
struct AnotherExampleView: View {
    var body: some View {
        NavigationLink(destination: LayoutDemoUIViewWrapper()) {
            Text("Open Layout Demo")
        }
    }
} 