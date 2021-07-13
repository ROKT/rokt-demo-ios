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
    @ObservedObject var viewModel: CustomerDetailsViewModel
    
    @Binding var popToRootView : Bool
    
    @State var moveToNextView = false
    @State var isAdvancedDetailsShown = false
    
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
                    
                    DetailPickerView(title: "Country",
                                     items: $viewModel.countries,
                                     selectedItem: $viewModel.selectedCountry)
                    
                    Button(action: {
                        isAdvancedDetailsShown.toggle()
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Advanced options").foregroundColor(.black)
                            Image("downIcon")
                                .rotationEffect(.degrees(self.isAdvancedDetailsShown ? 180.0 : 0.0))
                                .animation(Animation.linear(duration: 0.2))
                            Spacer()
                        }
                    })
                    
                    if isAdvancedDetailsShown {
                        AdvancedDetails(advancedDetails: $viewModel.advancedDetailsKV)
                    }
                    
                    NavigationLink(destination:
                                    ConfirmationView(viewModel: viewModel.getConfirmationViewModel(),
                                                        popToRootView: $popToRootView),
                                   isActive: self.$moveToNextView) {
                        Text("") }.hidden()
                    
                }.padding()
            }.modifier(NavigationBarBlackWithButton(title: "",
                                                    trailingButtonTitle: "QUIT DEMO",
                                                    trailingButtonAction: {
                                                        popToRootView = false
                                                    }))
            Button("Continue") {
                moveToNextView = true
            }.buttonStyle(ButtonDefault())
            .background(Color.white)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 30, trailing: 10))
            
        }
        .background(Color.gray3)
        .edgesIgnoringSafeArea([.bottom])
    }
    
 
}

private struct AdvancedDetails: View {
    @Binding var advancedDetails: [KeyValue]
    
    var body: some View {
        VStack {
            Text("Brief sentence explaining this step lorem ipsum the quick brown fox jumps over the lazy dog.")
                .font(.defaultFont(.subtitle2))
                .foregroundColor(.textColor)
            
            ForEach(advancedDetails.indices, id: \.self) { index in
                KeyValueView(model: Binding(
                                get: {
                                    return advancedDetails[index]
                                },
                                set: { (newValue) in
                                    advancedDetails[index] = newValue
                                }))
            }
            
        }
    }
}

private struct KeyValueView: View {
    @Binding var model: KeyValue
    var body: some View {
        HStack() {
            DetailTextFieldView(title: "AttributeName",
                                textHolder: $model.key)
            DetailTextFieldView(title: "Value",
                                textHolder: $model.value)
        }
    }
}

struct CustomerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerDetailsView(viewModel: CustomerDetailsViewModel(
                                customerDetails:
                                    CustomerDetailsModel(state: "NSW",
                                                         postcode: "2112",
                                                         country: ["US", "AU"]),
                                advancedDetails: ["name": "firstname"],
                                
                                accountDetail:
                                    AccountDetailViewData(accountId: "",
                                                          viewName: "",
                                                          placementLocation1: "",
                                                          placementLocation2: "")),
                            popToRootView: .constant(true))
    }
}
