//
//  CustomCheckoutView.swift
//  RoktDemo
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import SwiftUI

struct CustomCheckoutView: View {
    @State var isDisclaimerShown = false
    
    let model: CustomConfigurationPageModel
    var body: some View {
        ZStack {
            
            VStack {
                VStack(alignment: .center){
                    Image(model.iconURL)
                        .background(Color.black)
                        .foregroundColor(Color.white)
                        .padding()
                    
                    Text(model.title)
                        .foregroundColor(.white)
                        .font(.defaultHeadingFont(.header1))
                }
                .frame(minWidth: 0,
                       idealWidth: .infinity,
                       maxWidth: .infinity,
                       minHeight: 0,
                       idealHeight: 200,
                       maxHeight: 200,
                       alignment: .center)
                .padding()
                .background(Color.black)
                
                Spacer()
                ScrollView{
                    VStack {
                        Text(model.longDescription)
                            .lineLimit(.none)
                            .font(.defaultFont(.text))
                            .padding()
                    }
                }
                Spacer()
                Button(action: {
                    isDisclaimerShown.toggle()
                }, label: {
                    Text("Let's begin")
                })
                .padding()
                .buttonStyle(ButtonDefaultOutlined())
                
            }.opacity(isDisclaimerShown ? 0 : 1)
            .padding(.bottom, 20)

            if isDisclaimerShown {
                AlertView(shown: $isDisclaimerShown, message: AlertView.template1) {
                    
                }
            }
        }
        .background(isDisclaimerShown ? Color.black : Color.white)
        .edgesIgnoringSafeArea([.bottom])
        .modifier(NavigationBarBlack(title: ""))
        
    }
}

struct CustomCheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCheckoutView(model:
                            CustomConfigurationPageModel(title: "Custom Checkout Flow",
                                                         shortDescription: "",
                                                         longDescription: """
   The Custom Checkout Flow allows you to preview a specific placement from a specific account in an unbranded confirmation page.
   This allows you to preview the specific UI of this placement and experience the in-app behaviour of the Rokt placement.
   \n\nNote: In order to preview a specific placement, you will require details about your Rokt account and placement configuration.
   If you do not have these, please reach out to your Rokt Account Manager.

   """,
                                                         iconURL: "CustomerCheckout"))
    }
}
