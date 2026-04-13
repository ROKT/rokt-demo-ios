import SwiftUI

struct ShoppableAdsExecutionView: View {
    @ObservedObject var viewModel: ShoppableAdsExecutionViewModel
    @Binding var popToRootView: Bool

    @State private var hasExecuted = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Status section
            VStack(alignment: .leading, spacing: 8) {
                Text("Status")
                    .font(.defaultBoldFont(.header2))
                    .foregroundColor(.titleColor)

                Text(viewModel.statusMessage)
                    .font(.defaultFont(.text))
                    .foregroundColor(.textColor)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .border(Color.borderColor, width: 1)
            }
            .padding()

            // Event log section
            VStack(alignment: .leading, spacing: 8) {
                Text("SDK Events")
                    .font(.defaultBoldFont(.subtitle1))
                    .foregroundColor(.titleColor)
                    .padding(.horizontal)

                if viewModel.eventLog.isEmpty {
                    Text("Waiting for events...")
                        .font(.defaultFont(.subtitle2))
                        .foregroundColor(.subtitleColor)
                        .padding()
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(viewModel.eventLog.indices, id: \.self) { index in
                                HStack(spacing: 8) {
                                    Text("\(index + 1).")
                                        .font(.defaultFont(.subtitle2))
                                        .foregroundColor(.subtitleColor)
                                    Text(viewModel.eventLog[index])
                                        .font(.defaultFont(.text))
                                        .foregroundColor(.textColor)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                            }
                        }
                    }
                    .frame(maxHeight: 200)
                    .background(Color.white)
                    .border(Color.borderColor, width: 1)
                    .padding(.horizontal)
                }
            }

            Spacer()

            // Info note
            Text("The Shoppable Ads overlay is presented by the Rokt SDK automatically on top of this view.")
                .font(.defaultFont(.subtitle2))
                .foregroundColor(.subtitleColor)
                .multilineTextAlignment(.center)
                .padding()
        }
        .onAppear {
            guard !hasExecuted else { return }
            hasExecuted = true
            viewModel.executeShoppableAds()
        }
        .background(Color.gray3)
        .edgesIgnoringSafeArea([.bottom])
        .modifier(NavigationBarBlackWithButton(
            title: "Shoppable Ads",
            trailingButtonTitle: Constants.Strings.exitDemo,
            trailingButtonAction: {
                popToRootView = false
            }))
    }
}

struct ShoppableAdsExecutionView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppableAdsExecutionView(
            viewModel: ShoppableAdsExecutionViewModel(
                accountData: ShoppableAdsAccountData(
                    tagID: ShoppableAdsDefaults.tagID,
                    stripePublishableKey: "pk_test_example",
                    viewName: ShoppableAdsDefaults.viewName),
                attributes: ShoppableAdsDefaults.attributes),
            popToRootView: .constant(true))
    }
}
