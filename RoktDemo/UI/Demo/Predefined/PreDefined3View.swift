//
//  SwiftUIView.swift
//  RoktDemo
//
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import SwiftUI
import Rokt_Widget

struct PreDefined3View: View {
    let viewModel: PreDefinedViewModel
    @Binding var popToRootView : Bool
    
    let roktEmbedded1 = RoktEmbeddedSwiftUIView()
    @State private var embeddedSize: CGFloat = 0
    @State var placementDisplayed = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 0) {
                Congratulation(isBranded: viewModel.model.isBranded)
                PostConfirmation()
                
                roktEmbedded1
                    .background(Color.white)
                    .frame(height: self.embeddedSize, alignment: .center)
                    .padding(.top, 10)
            }
            .padding()
        }.onAppear {
            if !placementDisplayed {
                showPlacement()
            }
        }
        .background(Color.preDefinedWhite)
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

struct Congratulation: View {
    let isBranded: Bool
    var body: some View {
        if isBranded {
            HStack {
                Spacer()
                Image("ShareGreenIcon")
                    .padding([.top, .bottom])
            }
        }
        TextLato(text: "Congratulations!",
                 size: 26,
                 color: isBranded ? .preDefined3Green : .preDefined3Bule,
                 isBold: true,
                 isItalic: true)
            .padding(.bottom)
        
        TextLato(text: "Your ad has been created! Please note, ads and features may take a moment to go to live. Any payment confirmation and invoices will be sent to you by email.",
                 size: 16,
                 color: .preDefined3Black1
        ).padding(.bottom)
        
        Divider()
        
    }
}

struct PostConfirmation: View {
    var body: some View {
        
        TextLato(text: "Post your ad on eBay for FREE",
                 size: 16,
                 isBold: true
        ).padding([.top, .bottom])
        
        TextLato(text: "Increase your changes of selling with access to up to 11 million Aussies each month.",
                 size: 12,
                 color: .preDefined3Gray2)
            .padding(.bottom)
        
        Image("EbayLogo")
            .padding(.bottom)
        
        TextLato(text: "*Limited to 2 items per month. T&C’s Apply.",
                 size: 9,
                 color: .preDefined3Gray3)
            .padding(.bottom)
        
        Divider()
        
    }
}


private struct TextLato: View {
    let text: String
    let size: CGFloat
    var color: Color = .preDefined3Black2
    var isBold: Bool = false
    var isItalic: Bool = false
    var body: some View {
        Text(text)
            .foregroundColor(color)
            .font(.latoFont(size: size))
            .active(isItalic, Text.italic)
            .active(isBold, Text.bold)
            .multilineTextAlignment(.center)
        
    }
}

extension Text {
    func active(
        _ active: Bool,
        _ modifier: (Text) -> () -> Text
    ) -> Text {
        guard active else { return self }
        return modifier(self)()
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

struct PreDefined3View_Previews: PreviewProvider {
    static var previews: some View {
        PreDefined3View(viewModel:
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
