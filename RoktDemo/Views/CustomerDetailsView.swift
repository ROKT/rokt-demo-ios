//
//  CustomerDetailsView.swift
//  RoktDemo
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import SwiftUI

struct CustomerDetailsView: View {
    @ObservedObject var viewModel = CustomerDetailsViewModel()
    
    @Binding var popToRootView : Bool
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Step 2/2")
                        .font(.defaultFont(.text))
                        .foregroundColor(.subtitleColor)
                    
                    Text("Customer details")
                        .font(.defaultBoldFont(.header2))
                    
                    Text("Please enter your customer details to be used in the offer selection process. ")
                        .font(.defaultFont(.subtitle1))
                        .foregroundColor(.textColor)
                    
                    DetailTextFieldView(title: "State",
                                        textHolder: $viewModel.state)
                    
                    DetailTextFieldView(title: "Postcode",
                                        textHolder: $viewModel.postcode)
                    
                    
                }.padding()
            }.modifier(NavigationBarBlackWithButton(title: "",
                                                    trailingButtonTitle: "QUIT DEMO",
                                                    trailingButtonAction: {
                                                        popToRootView = false
                                                    }))
            Button("Continue") {
                //            viewModel.continueAction()
                //            moveToNextView = true
            }.buttonStyle(ButtonDefault())
            .background(Color.white)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 30, trailing: 10))
            
        }
        .background(Color.gray3)
        .edgesIgnoringSafeArea([.bottom])
    }
}

struct CustomerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerDetailsView(popToRootView: .constant(true))
    }
}
