import SwiftUI
import Rokt_Widget
import RoktStripePaymentExtension

struct ShoppableAdsAccountView: View {
    @ObservedObject var viewModel: ShoppableAdsAccountViewModel

    @State var moveToNextView = false
    @Binding var popToRootView: Bool

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Step 1/2")
                        .font(.defaultFont(.text))
                        .foregroundColor(.subtitleColor)

                    Text("Account details")
                        .font(.defaultBoldFont(.header2))
                        .foregroundColor(.textColor)

                    DetailTextView(
                        text: "Enter your Rokt Account ID, Stripe Publishable Key, and the View Name for the Shoppable Ads placement you'd like to preview.",
                        font: .defaultFont(.subtitle1))

                    DetailTextFieldView(
                        title: "Account ID",
                        textHolder: $viewModel.tagID,
                        errorMessage: $viewModel.tagIDError,
                        hasError: $viewModel.tagIDHasError)

                    DetailTextFieldView(
                        title: "Stripe Publishable Key",
                        textHolder: $viewModel.stripePublishableKey,
                        errorMessage: $viewModel.stripeKeyError,
                        hasError: $viewModel.stripeKeyHasError)

                    DetailTextFieldView(
                        title: "View Name",
                        textHolder: $viewModel.viewName)

                    NavigationLink(
                        destination: ShoppableAdsAttributesView(
                            viewModel: ShoppableAdsAttributesViewModel(
                                accountData: viewModel.getAccountData()),
                            popToRootView: $popToRootView),
                        isActive: $moveToNextView) {
                        Text("")
                    }.hidden()
                }.padding()
            }
            .modifier(NavigationBarBlackWithButton(
                title: "",
                trailingButtonTitle: Constants.Strings.exitDemo,
                trailingButtonAction: {
                    popToRootView = false
                }))

            Button(Constants.Strings.continueDemo) {
                if viewModel.isValidToContinue() {
                    // Initialize Rokt SDK and register Stripe payment extension early
                    Rokt.initWith(roktTagId: viewModel.tagID)
                    if let stripeExt = RoktStripePaymentExtension(applePayMerchantId: ShoppableAdsDefaults.applePayMerchantId) {
                        Rokt.registerPaymentExtension(stripeExt, config: [
                            "stripeKey": viewModel.stripePublishableKey
                        ])
                    }
                    moveToNextView = true
                }
            }
            .buttonStyle(ButtonDefault())
            .background(Color.white)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 30, trailing: 10))
        }
        .keyboardSafe()
        .animation(.easeOut(duration: 0.19))
        .background(Color.gray3)
        .edgesIgnoringSafeArea([.bottom])
    }
}

struct ShoppableAdsAccountView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppableAdsAccountView(
            viewModel: ShoppableAdsAccountViewModel(),
            popToRootView: .constant(true))
    }
}
