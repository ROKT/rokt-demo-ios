//
//  PreDefined1View.swift
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

struct PreDefined1View: View {
    let viewModel: PreDefinedViewModel
    @Binding var popToRootView : Bool
    
    let roktEmbedded1 = RoktEmbeddedSwiftUIView()
    @State private var embeddedSize: CGFloat = 0
    @State var placementDisplayed = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0){
                ThankYouView()
                ConfirmationsView()
                if viewModel.model.isBranded {
                    OrderSummaryView()
                }
                
                roktEmbedded1
                    .background(Color.white)
                    .frame(height: self.embeddedSize, alignment: .center)
                    .padding(.top, 10)
            }
        }.onAppear {
            if !placementDisplayed {
                showPlacement()
            }
        }
        .background(Color.gray4)
        .modifier(NavigationBarBlackWithButton(title: "",
                                               trailingButtonTitle: Constants.Strings.exitDemo,
                                               trailingButtonAction: {
            popToRootView = false
        }))
        .edgesIgnoringSafeArea([.bottom])
    }
    
    private func showPlacement() {
        
        var placements = [String: RoktEmbeddedView]()
        let placementLocation1 = viewModel.model.placeholderName
        if !placementLocation1.isEmpty {
            placements[placementLocation1] = roktEmbedded1.embedded
        }
        
        Rokt.execute(viewName: viewModel.model.viewName, attributes: viewModel.getAttributes(),
                     placements: placements,
                     onLoad: {
            self.placementDisplayed = true
        },
                     onEmbeddedSizeChange: { selectedPlacement, widgetHeight in
            
            embeddedSize = widgetHeight
            
        })
    }
}

private struct ThankYouView: View {
    var body: some View {
        VStack {
            ZStack{
                HStack(alignment: .center) {
                    TextLato(text: "Thank you", size: 20)
                }
                HStack() {
                    Spacer()
                    Image("ShareIcon")
                        .padding()
                }
            }
            
            Divider()
        }.background(Color.preDefinedWhite)
    }
}

private struct ConfirmationsView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Image("DoneIcon")
            TextLato(text: "You just got an amazing deal!", size: 22, isBold: true)
                .padding(.bottom, 5)
            
            TextLato(text: "We sent a receipt to\nyour email", size: 16)
                .multilineTextAlignment(.center)
            
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .background(Color.preDefinedWhite)
    }
}

private struct OrderSummaryView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack {
                TextLato(text: "Order Details", size: 16)
                Spacer()
                TextLato(text: "Total: $0", size: 16)
                Image("ArrowUp")
            }.padding()
            
            Divider(color: .preDefined1Gray1)
            
            TextLato(text: "Two-Month Subscription to Adventure Academy - Adventure Academy",
                     size: 14,
                     color: .preDefined1Gray2)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding()
            
            Divider(color: .preDefined1Gray1)
            
            TextLato(text: "View your Groupons", size: 16, color: .preDefined1Green, isBold: true)
                .padding()
            
            
        }
        .background(Color.preDefinedWhite)
        .padding(.top, 10)
    }
}

private struct TextLato: View {
    let text: String
    let size: CGFloat
    var color: Color = .preDefined1Black
    var isBold: Bool = false
    var body: some View {
        Text(text)
            .foregroundColor(color)
            .font(.latoFont(size: size, isBold: isBold))
    }
}

private struct Divider: View {
    var color: Color = .preDefined1Gray3
    var body: some View {
        Rectangle().fill(color)
            .frame(height: 1,
                   alignment: .center)
    }
}

struct PreDefined1View_Previews: PreviewProvider {
    static var previews: some View {
        PreDefined1View(viewModel:
                            PreDefinedViewModel(model:
                                                    PreDefinedScreenModel(
                                                        title: "",
                                                        shortDescription: "",
                                                        longDescription: "", iconURL: "",
                                                        descriptions: [],
                                                        tagID: "",
                                                        viewName: "", placeholderName: "",
                                                        type: "",
                                                        attributes: ["":""],
                                                        isBranded: false)),
                        popToRootView: .constant(false))
    }
}
