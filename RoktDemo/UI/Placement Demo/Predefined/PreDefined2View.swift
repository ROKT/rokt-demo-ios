//
//  PreDefined2View.swift
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

struct PreDefined2View: View {
    let viewModel: PreDefinedViewModel
    @Binding var popToRootView : Bool
    
    let roktEmbedded1 = RoktEmbeddedSwiftUIView()
    @State private var embeddedSize: CGFloat = 0
    @State var placementDisplayed = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0){
                Header(isBranded: viewModel.model.isBranded)
                WhatsNext(isBranded: viewModel.model.isBranded)
                
                roktEmbedded1
                    .background(Color.white)
                    .frame(height: self.embeddedSize, alignment: .center)
                    .padding(.top, 10)
                
                OrderNumber()
                EventInfo()
                
            }.padding()
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

private struct Header: View {
    let isBranded: Bool
    var body: some View {
        if isBranded {
            Image("TicketIcon")
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
        }
        TextArial(text: "Have a great time!", size: 30, isBold: true)
            .padding(.bottom, 20)
    }
}

private struct WhatsNext: View {
    let isBranded: Bool
    var body: some View {
        TextArial(text: "Whats Next?", size: 16, color: .preDefined2Gray1)
            .padding(.bottom, 10)
        if isBranded {
            TextArial(text: "Just scan your phone and you’re in. Your tickets will be ready for you in the StuHhub app and your StubHub account in a few minutes.", size: 16)
        } else {
            TextArial(text: "Just scan your phone and you’re in. Your tickets will be ready for you in the app and your account in a few minutes.", size: 16)
        }
        
        Button(action: {}) {
            TextArial(text: "View order", size: 16, color: .preDefinedWhite, isBold: true)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                .background(Color.preDefined2Purple)
                .cornerRadius(5)
                .padding([.top,.bottom],10)
        }
        
        Button(action: {}) {
            TextArial(text: "Find more events",
                      size: 16,
                      isBold: true)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                .background(Color.preDefinedWhite)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.preDefined2Black, lineWidth: 1.5)
                )
                .padding(.bottom,20)
        }
        
        Divider()
        
    }
}

private struct OrderNumber: View {
    var body: some View {
        TextArial(text: "Order number", size: 16, color: .preDefined2Gray1)
            .padding(.top)
        TextArial(text: "123456789", size: 16)
            .padding([.top, .bottom])
        Divider()
    }
}

private struct EventInfo: View {
    var body: some View {
        TextArial(text: "Event info", size: 16, color: .preDefined2Gray1)
            .padding(.top)
        TextArial(text: "PARKING PASSES ONLY Gardner-Webb at Floria State Seminoles Basketball Tickets",
                  size: 16, isBold: true)
            .padding(.top)
        
        TextArial(text: "Mon, Dec 21, 2020 - 08:01 pm - Donald L. Tucket Center Parking Lots - Tallahassee, FL",
                  size: 16, color: .preDefined2Gray1, isBold: true)
            .padding([.top, .bottom])
        
        Button(action: {}) {
            HStack {
                Image("CalendarIcon")
                    .resizable()
                    .frame(width: 26, height: 28)
                TextArial(text: "Add to calendar", size: 16)
                    .padding([.top, .bottom])
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .background(Color.preDefinedWhite)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.preDefined2Black, lineWidth: 1.5)
            )
        }
    }
}

private struct TextArial: View {
    let text: String
    let size: CGFloat
    var color: Color = .preDefined2Black
    var isBold: Bool = false
    var body: some View {
        Text(text)
            .foregroundColor(color)
            .font(.arialFont(size: size, isBold: isBold))
            .lineSpacing(5)
    }
}

private struct Divider: View {
    var color: Color = .preDefined2Gray2
    var body: some View {
        Rectangle().fill(color)
            .frame(height: 1,
                   alignment: .center)
    }
}

struct PreDefined2View_Previews: PreviewProvider {
    static var previews: some View {
        PreDefined2View(viewModel:
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
