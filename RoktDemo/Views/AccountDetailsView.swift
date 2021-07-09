//
//  AccountDetailsView.swift
//  RoktDemo
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import SwiftUI

struct AccountDetailsView: View {
    @ObservedObject var viewModel: AccountDetailsViewModel
    
    @State var moveToNextView = false
    @Binding var popToRootView : Bool
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Step 1/2")
                        .font(.defaultFont(.text))
                        .foregroundColor(.subtitleColor)
                    
                    Text("Account details")
                        .font(.defaultBoldFont(.header2))
                    
                    Text("Please enter your Rokt Account ID and the ViewName and Placement Location Name of the placement you’d like to preview. If you do not know these details, please contact your Rokt Account Manager.")
                        .font(.defaultFont(.subtitle1))
                        .foregroundColor(.textColor)
                    
                    
                    DetailTextFieldView(title: "Account ID",
                                        textHolder: $viewModel.accountId,
                                        errorMessage: $viewModel.accountIdError,
                                        hasError: $viewModel.accountIdHasError)
                    
                    DetailTextFieldView(title: "View Name",
                                        textHolder: $viewModel.viewName)
                    
                    DetailTextFieldView(title: "Placement Location 1",
                                        textHolder: $viewModel.placementLocation1)
                    
                    DetailTextFieldView(title: "Placement Location 2",
                                        textHolder: $viewModel.placementLocation2)
                    NavigationLink(destination:
                                    CustomerDetailsView(viewModel: viewModel.getCustomerDetailsViewModel(),
                                                        popToRootView: $popToRootView),
                                   isActive: self.$moveToNextView) {
                        Text("") }.hidden()
                }.padding()
            }
            .modifier(NavigationBarBlackWithButton(title: "",
                                                   trailingButtonTitle: "QUIT DEMO",
                                                   trailingButtonAction: {
                                                    popToRootView = false
                                                   }))
            Button("Continue") {
                if viewModel.isValidToContinue() {
                    moveToNextView = true
                }
            }.buttonStyle(ButtonDefault())
            .background(Color.white)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 30, trailing: 10))
            
        }
        .background(Color.gray3)
        .edgesIgnoringSafeArea([.bottom])
        
    }
}

struct AccountDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailsView(viewModel: AccountDetailsViewModel(
                            CustomConfigurationPageModel(title: "",
                                                         shortDescription: "",
                                                         longDescription: "",
                                                         iconURL: "",
                                                         accountDetails:
                                                            AccountDetailsModel(accountID: "123",
                                                                                 viewName: "",
                                                                                 placementLocation1: "",
                                                                                 placementLocation2: "") ,customerDetails: CustomerDetailsModel(state: "", postcode: "", country: []), advancedDetails: [:])), popToRootView: .constant(true))
    }
}
