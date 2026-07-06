//
//  LayoutDemoView.swift
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
import CodeScanner
import Rokt_Widget

struct LayoutDemoView: View {
    @StateObject var viewModel: LayoutDemoViewModel = LayoutDemoViewModel()
    @EnvironmentObject var appState: AppState
    
    var roktEmbedded = RoktEmbeddedSwiftUIView()
    
    @State var isShowingBarcodeScanner = false
    @State private var isShowingManualEntry = false

    @State private var embeddedSize: CGFloat = 0
    var body: some View {
        ZStack {
            if #available(iOS 14.0, *) {
                ScrollView{
                    VStack(alignment: .leading) {
                        HeaderView(title: "Layout Library")
                        Button(action: {
                            viewModel.uiState = .loading
                            isShowingBarcodeScanner = true
                        }) {
                            Text("Scan new Layout")
                        }
                        .padding(.top)
                        .buttonStyle(ButtonDefault())
                        .sheet(isPresented: $isShowingBarcodeScanner) {
                            CodeScannerView(codeTypes: [.qr], completion: handleScan)
                        }

                        Button(action: {
                            isShowingManualEntry = true
                        }) {
                            Text("Enter Manually")
                        }
                        .padding(.top, 8)
                        .buttonStyle(ButtonDefaultOutlined())
                        .sheet(isPresented: $isShowingManualEntry) {
                            ManualEntryView(viewModel: viewModel, isPresented: $isShowingManualEntry)
                        }

                        switch viewModel.uiState {
                        case .hasData, .done:
                            // TODO: Re-enable the refresh button once layoutVariantIds are stablised
                            //     Button(action: {
                            //         viewModel.uiState = .hasData
                            //     }) {
                            //         Text("Refresh preview")
                            //     }
                            //     .padding(.top)
                            //     .buttonStyle(ButtonDefaultOutlined())
                            
                            roktEmbedded
                                .frame(height: self.embeddedSize, alignment: .center)
                            
                        case .error(error: let error):
                            ErrorView(viewModel: ErrorViewModel(error: nil, barcodeErrorMessage: error))
                                .modifier(NavigationBarGray(title: ""))
                                .background(Color.white)
                        default:
                            EmptyView()
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding()
                }.onAppear {
                    viewModel.uiState = .initiated
                    if let previewJsonString = appState.previewParameterString {
                        viewModel.parseQRcodeResult(previewJsonString)
                    }
                }
                .onChange(of: viewModel.uiState){ newState in
                    print("[LayoutDemoView] uiState changed → \(newState)")
                    if newState == .hasData {
                        showPlacement()
                    }
                    if newState == .loading {
                        appState.previewParameterString = nil
                    }
                }
            } else {
                VStack {
                    HeaderView(title: "Layout Library")
                    Text("Layouts is supported on iOS 15+ for now")
                }
            }
        }.background(Color.gray3)
            .edgesIgnoringSafeArea([.bottom])
            .modifier(NavigationBarGray(title: ""))
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingBarcodeScanner = false
        switch result {
        case .success(let result):
            viewModel.parseQRcodeResult(result.string)
        case .failure(let error):
            viewModel.uiState = .error(error: error.localizedDescription)
        }
    }
    func showPlacement() {
        let attrs = viewModel.getAttributes()
        print("[LayoutDemoView] showPlacement called. attributes=\(attrs)")
        Rokt.selectPlacements(
            identifier: "",
            attributes: attrs,
            placements: ["#rokt-placeholder": roktEmbedded.embedded]
        ) { event in
            print("[LayoutDemoView] Rokt event: \(event)")
            switch event {
            case let sizeChanged as RoktEvent.EmbeddedSizeChanged:
                embeddedSize = sizeChanged.updatedHeight
                viewModel.uiState = .done
            case is RoktEvent.PlacementReady,
                 is RoktEvent.PlacementInteractive,
                 is RoktEvent.PlacementClosed:
                viewModel.uiState = .done
            case is RoktEvent.PlacementCompleted:
                embeddedSize = 0
                viewModel.uiState = .done
            default:
                break
            }
        }
    }
}

struct LayoutDemoView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutDemoView()
    }
}
