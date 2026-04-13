import SwiftUI

struct ShoppableAdsAttributesView: View {
    @ObservedObject var viewModel: ShoppableAdsAttributesViewModel

    @State var moveToNextView = false
    @Binding var popToRootView: Bool

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Step 2/2")
                        .font(.defaultFont(.text))
                        .foregroundColor(.subtitleColor)

                    Text("Attributes")
                        .font(.defaultBoldFont(.header2))
                        .foregroundColor(.textColor)

                    DetailTextView(
                        text: "Configure the attributes sent to the Shoppable Ads placement. Basic fields are pre-populated with test defaults. Add additional attributes as needed.",
                        font: .defaultFont(.subtitle1))

                    // Basic fields section
                    Text("Basic Fields")
                        .font(.defaultBoldFont(.subtitle1))
                        .foregroundColor(.titleColor)
                        .padding(.top, 8)

                    DetailTextFieldView(title: "Email", textHolder: $viewModel.email)
                    DetailTextFieldView(title: "First Name", textHolder: $viewModel.firstname)
                    DetailTextFieldView(title: "Last Name", textHolder: $viewModel.lastname)
                    DetailTextFieldView(title: "Confirmation Ref", textHolder: $viewModel.confirmationref)
                    DetailTextFieldView(title: "Country", textHolder: $viewModel.country)
                    DetailTextFieldView(title: "Sandbox", textHolder: $viewModel.sandbox)

                    // Additional attributes section
                    Text("Additional Attributes")
                        .font(.defaultBoldFont(.subtitle1))
                        .foregroundColor(.titleColor)
                        .padding(.top, 8)

                    ForEach(viewModel.additionalAttributes.indices, id: \.self) { index in
                        ShoppableAdsAttributeRow(
                            model: Binding(
                                get: { viewModel.additionalAttributes[index] },
                                set: { viewModel.additionalAttributes[index] = $0 }),
                            onDelete: {
                                viewModel.removeAttribute(at: index)
                            })
                    }

                    // Add Attribute button
                    Button(action: {
                        viewModel.addAttribute()
                    }, label: {
                        HStack {
                            Spacer()
                            Image(systemName: "plus.circle")
                                .foregroundColor(viewModel.canAddMoreAttributes ? .black : .gray)
                            Text("Add Attribute")
                                .foregroundColor(viewModel.canAddMoreAttributes ? .black : .gray)
                            Spacer()
                        }
                        .padding()
                        .background(viewModel.canAddMoreAttributes ? Color.white : Color.gray.opacity(0.3))
                        .cornerRadius(8)
                    })
                    .disabled(!viewModel.canAddMoreAttributes)
                    .padding(.top, 10)

                    NavigationLink(
                        destination: ShoppableAdsExecutionView(
                            viewModel: ShoppableAdsExecutionViewModel(
                                accountData: viewModel.accountData,
                                attributes: viewModel.getAllAttributes()),
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

            Button("Execute Shoppable Ads") {
                moveToNextView = true
            }
            .buttonStyle(ButtonDefault())
            .background(Color.white)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 30, trailing: 10))
        }
        .keyboardSafe()
        .animation(.easeOut(duration: 0.16))
        .background(Color.gray3)
        .edgesIgnoringSafeArea([.bottom])
    }
}

private struct ShoppableAdsAttributeRow: View {
    @Binding var model: KeyValue
    let onDelete: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            DetailTextFieldView(title: "Key", textHolder: $model.key)
            DetailTextFieldView(title: "Value", textHolder: $model.value)
            Button(action: onDelete) {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(.errorColor)
                    .padding(.top, 24)
            }
        }
    }
}

struct ShoppableAdsAttributesView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppableAdsAttributesView(
            viewModel: ShoppableAdsAttributesViewModel(
                accountData: ShoppableAdsAccountData(
                    tagID: ShoppableAdsDefaults.tagID,
                    stripePublishableKey: "",
                    viewName: ShoppableAdsDefaults.viewName)),
            popToRootView: .constant(true))
    }
}
