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

struct DemoItemSummaryView: View {
    @State var isDisclaimerShown = false
    @State var pushActive = false
    
    let viewModel: DemoItemSummaryViewModel
    var body: some View {
        ZStack {
            
            VStack {
                DemoHeaderView(image: viewModel.summaryModel.iconURL,
                               title: viewModel.summaryModel.title)
                
                Spacer()
                DemoContentView(longDescription: viewModel.summaryModel.longDescription,
                                descriptions: viewModel.summaryModel.descriptions)
                
                Spacer()
                Button(action: {
                    isDisclaimerShown.toggle()
                }, label: {
                    Text("Let's begin")
                        .font(.defaultButtonFont())
                    
                })
                .padding()
                .buttonStyle(ButtonDefaultOutlined())
                
            }.opacity(isDisclaimerShown ? 0 : 1)
            .padding(.bottom, 20)
            

            if isDisclaimerShown {
                AlertView(shown: $isDisclaimerShown, message: viewModel.summaryModel.disclaimerMessage) {
                    pushActive = true
                }
            }
            NavigationLink(destination: getDestination(), isActive: self.$pushActive) { Text("") }.hidden()
        }
        .onAppear {
            viewModel.initializeRokt()
        }
        .background(isDisclaimerShown ? Color.titleColor : Color.white)
        .edgesIgnoringSafeArea([.bottom])
        .modifier(NavigationBarBlack(title: ""))
        
    }
    
    func getDestination() -> some View {
        if let model = viewModel.model as? DefaultPlacementExamplesModel  {
            return AnyView(FeatureWalkthroughView(viewModel:
                                                    FeatureWalkthroughViewModel(model: model, selectedScreen: 0)
                                                  ,popToRootView: $pushActive))
        } else if let model = viewModel.model as? CustomConfigurationPageModel {
            return AnyView(AccountDetailsView(viewModel: AccountDetailsViewModel(model), popToRootView: $pushActive))
        } else if let model = viewModel.model as? PreDefinedScreenModel {
            return AnyView(PreDefined1View(viewModel: PreDefinedViewModel(model: model), popToRootView: $pushActive))
        }
        return AnyView(EmptyView())
    }

}

private struct DemoHeaderView: View {
    let image: String
    let title: String
    var body: some View {
        VStack(alignment: .center){
            Image(image)
                .background(Color.titleColor)
                .foregroundColor(Color.white)
                .padding()
            
            Text(title)
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
        .background(Color.titleColor)
    }
}

struct DemoContentView: View {
    let longDescription: String?
    let descriptions: [DescriptionItem]
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                if let longDescription = longDescription, !longDescription.isEmpty {
                    DetailTextView(text: longDescription)
                        .padding()
                }
                ForEach(descriptions, id: \.self) { description in
                    DemoDescriptionItem(description: description)
                }
            }
        }
    }
}

struct DemoDescriptionItem: View {
    let description: DescriptionItem
    var body: some View {
        HStack {
            Image(description.iconURL)
                .padding()
            VStack(alignment: .leading, spacing: 4) {
                Text(description.title)
                    .font(.defaultBoldFont(.subtitle1))
                    .multilineTextAlignment(.leading)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                Text(description.text)
                    .font(.defaultFont(.text))
                    .foregroundColor(.gray9)
                    .multilineTextAlignment(.leading)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding([.leading, .trailing, .top])
        
    }
}

struct CustomCheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        DemoItemSummaryView(viewModel:
                                DemoItemSummaryViewModel(
                                    CustomConfigurationPageModel(title: "Custom Checkout Flow",
                                                                 shortDescription: "",
                                                                 longDescription: """
   The Custom Checkout Flow allows you to preview a specific placement from a specific account in an unbranded confirmation page.
   This allows you to preview the specific UI of this placement and experience the in-app behaviour of the Rokt placement.
   \n\nNote: In order to preview a specific placement, you will require details about your Rokt account and placement configuration.
   If you do not have these, please reach out to your Rokt Account Manager.

   """,
                                                                 iconURL: "CustomerCheckout",
                                                                 accountDetails:
                                                                    
                                                                    AccountDetailsModel(accountID: "",
                                                                                        viewName: "",
                                                                                        placementLocation1: "",
                                                                                        placementLocation2: "",
                                                                                        password: ""),
                                                                 customerDetails:
                                                                    CustomerDetailsModel(state: "NSW",
                                                                                                       postcode: "200",
                                                                                                       country:
                                                                                                        ["US","AU","UK","SG"]),
                                                                 advancedDetails:
                                                                                                            ["experience":"true"
                                                                                                             ,"majorCat":"true"]))
        )
    }
}
