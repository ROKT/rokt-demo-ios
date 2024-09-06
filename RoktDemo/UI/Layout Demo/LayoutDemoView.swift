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
    @ObservedObject var viewModel: LayoutDemoViewModel
    
    var roktEmbedded = RoktEmbeddedSwiftUIView()
    
    @State var isShowingBarcodeScanner = false

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
                        .onChange(of: viewModel.uiState){ newState in
                            if newState == .hasData {
                                showPlacement()
                            }
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
        Rokt.execute(viewName: "",
                     attributes: viewModel.getAttributes(),
                     placements: ["#rokt-placeholder": roktEmbedded.embedded],
                     onLoad: {
            viewModel.uiState = .done
        }, onUnLoad: {
            viewModel.uiState = .done
        }, onEmbeddedSizeChange: { selectedPlacement, widgetHeight in
            embeddedSize = widgetHeight
        })
    }
}

struct LayoutDemoView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutDemoView(viewModel: LayoutDemoViewModel())
    }
}
