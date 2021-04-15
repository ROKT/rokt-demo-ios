//
//  AlertView.swift
//  RoktDemo
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import SwiftUI

struct AlertView: View {
    
    @Binding var shown: Bool
    var message: String
    var positiveAction: () -> (Void)
    
    var body: some View {
        ZStack {
            VStack {
                
                Text("Disclaimer")
                    .font(.defaultBoldFont(.title))
                    .foregroundColor(.black)
                    .padding()
                
                Text(message)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .font(.defaultFont(.subtitle1))
                    .padding()
                
                HStack {
                    Button("Yes please") {
                        positiveAction()
                        shown.toggle()
                    }
                    .buttonStyle(ButtonDefaultOutlined())
                    
                    Button("No thanks") {
                        shown.toggle()
                    }
                    .buttonStyle(ButtonDefault())
                }.padding()
                
            }.background(Color.white)
            .padding()
            .clipped()
        }
        
    }
}

extension AlertView {
    static let template1 = """
This is a Rokt demo used to show Rokt’s in-app capabilities.
This demo does not capture or store any personal or device data.
\n\nAs you progress, try interacting with the Rokt placements by clicking “Yes please” or \"No thanks\".
"""
    static let template2 = """
This is a Rokt demo used to show Rokt’s in-app capabilities.
This demo does not capture or store any personal or device data.
\n\nAs you progress, try interacting with the Rokt placements by clicking “Yes please” or \"No thanks\".
\n\n Click ‘NEXT’ to progress through different placement types.
"""
}


struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(shown: .constant(true), message: AlertView.template2) {
            print("Clicked yes")
        }
            .background(Color.black)
    }
}
