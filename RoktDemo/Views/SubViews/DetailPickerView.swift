//
//  DetailPickerView.swift
//  RoktDemo
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import SwiftUI

struct DetailPickerView: View {
    @State var isCountryPickerShown = false
    
    let title: String
    @Binding var items: [String]
    @Binding var selectedItem: String
    
    var body: some View {
        VStack {
            Button(action: {
                isCountryPickerShown.toggle()
            }, label: {
                ZStack (alignment: .trailing, content: {
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text (title)
                            .font(.defaultFont(.subtitle2))
                            .foregroundColor(.subtitleColor)
                        TextField(title, text: $selectedItem)
                            .font(.defaultFont(.text))
                            .foregroundColor(.titleColor)
                            .multilineTextAlignment(.leading)
                            .disabled(true)
                    }
                    .padding()
                    .border(Color.borderColor,
                            width: 1)
                    .background(Color.white)
                    
                    Image("downIcon")
                        .padding()
                        .rotationEffect(.degrees(self.isCountryPickerShown ? 180.0 : 0.0))
                        .animation(Animation.linear(duration: 0.2))
                })
            })
            
            if isCountryPickerShown {
                Picker(title, selection: $selectedItem.onChange(selectionChanged)) {
                    ForEach(items, id: \.self) {
                        Text($0)
                    }
                }
            }
        }
    }
    func selectionChanged(_ selected: String) {
        isCountryPickerShown.toggle()
    }
}

struct DetailPickerView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPickerView(title: "Country", items: .constant(["US","AU"]), selectedItem: .constant("US"))
    }
}
