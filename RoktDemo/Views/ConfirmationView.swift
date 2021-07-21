//
//  ConfirmationView.swift
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

struct ConfirmationView: View {
    let viewModel: ConfirmationViewModel
    @Binding var popToRootView : Bool
    
    let roktEmbedded1 = RoktEmbeddedSwiftUIView()
    let roktEmbedded2 = RoktEmbeddedSwiftUIView()
    
    @State private var embeddedSize1: CGFloat = 0
    @State private var embeddedSize2: CGFloat = 0
    
    @State var placementDisplayed = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                Image("tick")
                
                Text("Thank you John Smith!")
                    .font(.defaultBoldFont(.title))
                    .foregroundColor(.titleColor)
                
                Text("Order #MH123456")
                    .font(.defaultFont(.text))
                    .foregroundColor(.textColor)
                
                Spacer(minLength: 20)
                
                roktEmbedded1
                    .background(Color.white)
                    .frame(height: self.embeddedSize1, alignment: .center)
                    .border(Color.borderColor, width: 1)
                
                roktEmbedded2
                    .background(Color.white)
                    .frame(height: self.embeddedSize2, alignment: .center)
                    .border(Color.borderColor, width: 1)
                
                OrderSummary()
                
                CustomerDetails()
            }
        }
        .onAppear {
            if !placementDisplayed {
                showPlacement()
            }
        }
        .padding()
        .background(Color.gray4)
        .modifier(NavigationBarBlackWithButton(title: "",
                                                trailingButtonTitle: "QUIT DEMO",
                                                trailingButtonAction: {
                                                    popToRootView = false
                                                }))
        .edgesIgnoringSafeArea([.bottom])
    }
    
    private func showPlacement() {
        var placements = [String:RoktEmbeddedView]()
        let placementLocation1 = viewModel.accountDetail.placementLocation1
        if !placementLocation1.isEmpty {
            placements[placementLocation1] = roktEmbedded1.embedded
        }
        
        let placementLocation2 = viewModel.accountDetail.placementLocation2
        if !placementLocation2.isEmpty {
            placements[placementLocation2] = roktEmbedded2.embedded
        }
        
        Rokt.execute(viewName: viewModel.accountDetail.viewName, attributes: viewModel.attributes,
                     placements: placements,
                     onLoad: {
                        self.placementDisplayed = true
                     },
                     onEmbeddedSizeChange: { selectedPlacement, widgetHeight in
                        if selectedPlacement == viewModel.accountDetail.placementLocation2 {
                            embeddedSize2 = widgetHeight
                        } else {
                            embeddedSize1 = widgetHeight
                        }
                     })
    }
}

private struct Devidedr: View {
    var body: some View {
        Rectangle().fill(Color.borderColor)
            .frame(height: 1,
                   alignment: .center)
    }
}

private struct OrderSummary: View {
    var body: some View {
        VStack( alignment: .leading, spacing: 0) {
            Text("Order summary")
                .font(.defaultBoldFont(.text))
                .foregroundColor(.titleColor)
                .padding()
            
            Devidedr()
            
            OrderSummaryItem(name: "Basic T-Shirt (3)",
                             price: "$59.95",
                             subText: "Medium",
                             color: .titleColor, isBold: true)
                .padding()
            
            Devidedr()
                .padding([.leading, .trailing])
            
            OrderSummaryItem(name: "Subtotal",
                             price: "$59.95",
                             color: .textColor)
                .padding([.top, .leading, .trailing])
            
            OrderSummaryItem(name: "Shipping",
                             price: "FREE",
                             color: .textColor)
                .padding()
            
            Devidedr()
                .padding([.leading, .trailing])
            
            OrderSummaryItem(name: "Total",
                             price: "$59.95",
                             color: .titleColor,
                             isBold: true)
                .padding()
            
        }
        .background(Color.white)
        .border(Color.borderColor, width: 1)
    }
}

private struct OrderSummaryItem: View {
    let name: String
    let price: String
    var subText: String? = nil
    let color: Color
    var isBold: Bool = false
    var body: some View {
        HStack {
            if let subText = subText {
                VStack(alignment: .leading) {
                    Text(name)
                        .font(isBold ? .defaultBoldFont(.text) : .defaultFont(.text))
                        .foregroundColor(color)
                    Text(subText)
                        .font(.defaultFont(.subtitle2))
                        .foregroundColor(.textColor)
                }
            } else {
                Text(name)
                    .font(isBold ? .defaultBoldFont(.text) : .defaultFont(.text))
                    .foregroundColor(color)
            }
            Spacer()
            Text(price)
                .font(isBold ? .defaultBoldFont(.text) : .defaultFont(.text))
                .foregroundColor(color)
        }
    }
}

private struct CustomerDetails: View {
    var body: some View {
        VStack( alignment: .leading, spacing: 0) {
            Text("Customer Details")
                .font(.defaultBoldFont(.text))
                .foregroundColor(.titleColor)
                .padding()
            
            Devidedr()
            
            CustomerDetailsItem(title: "Email", text: "demo@rokt.com")
            
            CustomerDetailsItem(title: "Shipping address",
                                text: "Rokt\n175 Varick Street\nNew York NY 10014\nUnited States\n(646) 693-7411")
            
            CustomerDetailsItem(title: "Billing address",
                                text: "Rokt\n175 Varick Street\nNew York NY 10014\nUnited States\n(646) 693-7411")
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Payment method")
                    .font(.defaultBoldFont(.text))
                    .foregroundColor(.titleColor)
                HStack {
                    Image("apple")
                        .padding([.leading,.trailing],10)
                        .padding([.top,.bottom],5)
                        .background(Color.gray9)
                        .cornerRadius(2.0)
                    Text("ending in 7594 – $59.95")
                        .font(.defaultFont(.text))
                        .foregroundColor(.textColor)
                    Spacer()
                }
            }.padding()
            
            CustomerDetailsItem(title: "Shipping method",
                                text: "Economy (4-6 Business Days)")
            
            Image("map")
                .resizable()
                .scaledToFit()
                .padding()
            
            
        }.background(Color.white)
        .border(Color.borderColor, width: 1)
    }
}

struct CustomerDetailsItem: View {
    let title: String
    let text: String
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.defaultBoldFont(.text))
                .foregroundColor(.titleColor)
            Text(text)
                .font(.defaultFont(.text))
                .foregroundColor(.textColor)
        }.padding()
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(viewModel:
                            ConfirmationViewModel(
                                accountDetail:
                                    AccountDetailViewData(accountId: "",
                                                          viewName: "",
                                                          placementLocation1: "",
                                                          placementLocation2: ""),
                                attributes: ["": ""]),popToRootView: .constant(false))
    }
}
