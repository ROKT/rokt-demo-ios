//
//  FeatureWalkthroughScreen.swift
//  RoktDemo
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import SwiftUI
import Rokt_Widget

struct FeatureWalkthroughView: View {
    let viewModel: FeatureWalkthroughViewModel
    
    let roktEmbedded = RoktEmbeddedSwiftUIView()
    
    @Binding var popToRootView : Bool
    @State var moveToNextView = false
    @State private var embeddedSize: CGFloat = 0
    @State var placementDisplayed = false
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.screen.title)
                        .font(.defaultHeadingFont(.header2))
                        .foregroundColor(.titleColor)
                    DetailTextView(text: viewModel.screen.description)
                    
                    if !viewModel.screen.isOverlay() {
                        Text("Preview")
                            .font(.defaultBoldFont(.header3))
                            .foregroundColor(.titleColor)
                            .padding([.top, .bottom])
                    }
                    roktEmbedded
                        .background(Color.white)
                        .frame(height: self.embeddedSize, alignment: .center)
                        .border(Color.borderColor, width: 1)
                    
                    NavigationLink(destination: FeatureWalkthroughView(viewModel: FeatureWalkthroughViewModel(model: viewModel.model, selectedScreen: viewModel.selectedScreen + 1), popToRootView: $popToRootView), isActive: self.$moveToNextView) { Text("") }.hidden()
                    
                }.padding()
            }
            if viewModel.screen.isOverlay() {
                Spacer()
                Button(action: {
                    showPlacement()
                },
                label: {
                    HStack {
                        Text("View example")
                        Image("eye")
                    }
                }).buttonStyle(ButtonDefaultOutlined())
                .padding()
            }
        }.padding(.bottom, 20)
        .background(Color.gray3)
        .edgesIgnoringSafeArea([.bottom])
        .modifier(NavigationBarBlackWithButton(title: viewModel.getNavigationTitle(),
                                               trailingButtonTitle: viewModel.getNavigationButtonText(),
                                               trailingButtonAction: {navigationButtonAction()}))
        .onAppear {
            if !viewModel.screen.isOverlay() && !placementDisplayed {
                showPlacement()
            }
        }
    }
    
    func navigationButtonAction() {
        if viewModel.isLastScreen() {
            popToRootView = false
        } else {
            moveToNextView = true
        }
    }
    
    func showPlacement() {
        Rokt.execute(viewName: viewModel.screen.viewName,
                     attributes: viewModel.getAttributes(),
                     placements: [viewModel.screen.placeholderName: roktEmbedded.embedded], onLoad: {
                        self.placementDisplayed = true
                        // Optional callback for when the Rokt placement loads
                     }, onUnLoad: {
                        // Optional callback for when the Rokt placement unloads
                     }, onShouldShowLoadingIndicator: {
                        // Optional callback to show a loading indicator
                     }, onShouldHideLoadingIndicator: {
                        // Optional callback to hide a loading indicator
                     },
                     onEmbeddedSizeChange: { selectedPlacement, widgetHeight in
                        embeddedSize = widgetHeight
                     })
    }
    
}

struct FeatureWalkthroughScreen_Previews: PreviewProvider {
    static var previews: some View {
        FeatureWalkthroughView(viewModel:
                                FeatureWalkthroughViewModel(
                                    model:
                                        DefaultPlacementExamplesModel(title: "",
                                                                      shortDescription: "",
                                                                      longDescription: "",
                                                                      iconURL: "",
                                                                      tagID: "",
                                                                      screens:
                                                                        [ScreenModel(title:
                                                                                        "Embedded Placement (1)",
                                                                                     description:
"""
The below preview shows an embedded placement without brand logos displayed. You can progress through the offers by clicking “Yes Please” or “No Thanks”.
\n
The placement UI can be customised to match your app, and create a native experience. This includes changing fonts, colours and multiple configurable options to alter the look and feel of the placement.

""",
                                                                                     viewName: "testiOS", placeholderName: "Location1", type: "overlay",
                                                                                     attributes: ["firstname":"name",
                                                                                                  "lastname":"family",
                                                                                                  "email":"something@example.com",
                                                                                                  "sandbox":"true", "country":"AU"])]
                                        ),selectedScreen: 0), popToRootView: .constant(true))
    }
}
