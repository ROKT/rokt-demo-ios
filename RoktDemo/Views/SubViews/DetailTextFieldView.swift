//
//  DetailTextFieldView.swift
//  RoktDemo
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import SwiftUI

struct DetailTextFieldView: View {
    let title: String
    @Binding var textHolder: String
    @Binding var errorMessage: String
    @Binding var hasError: Bool
    let isPassword: Bool
    
    init(title: String,
         textHolder: Binding<String>,
         errorMessage: Binding<String> = .constant("Validation error"),
         hasError: Binding<Bool> = .constant(false),
         isPassword: Bool = false) {
        self.title = title
        _textHolder = textHolder
        _errorMessage = errorMessage
        _hasError = hasError
        self.isPassword = isPassword
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text (title)
                    .font(.defaultFont(.subtitle2))
                    .foregroundColor(.subtitleColor)
                if isPassword {
                    SecureField("", text: $textHolder)
                        .font(.defaultFont(.text))
                        .foregroundColor(.titleColor)
                } else {
                    TextField("", text: $textHolder)
                        .font(.defaultFont(.text))
                        .foregroundColor(.titleColor)
                }
            }
            .padding()
            .border(hasError ? Color.errorColor : Color.borderColor,
                    width: 1)
            .background(Color.white)
            if hasError == true {
                HStack(spacing: 3) {
                    Image("ErrorValidation")
                    Text(errorMessage)
                        .font(.defaultFont(.subtitle1))
                        .foregroundColor(.errorColor)
                }
                .padding(.top, 5)
            }
        }
    }
}

struct DetailTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        DetailTextFieldView(title: "Account ID", textHolder: .constant(""), hasError: .constant(true))
    }
}
