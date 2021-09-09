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
                    .foregroundColor(.titleColor)
                    .padding()
                
                Text(message)
                    .frame(width: nil,
                           alignment: .leading)
                    .foregroundColor(.textColor)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(Constants.lineHeight)
                    .font(.defaultFont(.subtitle1))
                    .padding()
                
                Button("Start demo") {
                    positiveAction()
                    shown.toggle()
                }
                .buttonStyle(ButtonDefaultOutlined())
                .padding()
            }.background(Color.white)
            .padding()
            .clipped()
        }
        
    }
}

extension AlertView {
    static let template1 = """
As you progress, try interacting with the Rokt placements by tapping "Yes please" or "No thanks".
\n\nNo personal, account, or device data will be captured or stored.
"""
    static let template2 = """
As you progress, try interacting with the Rokt placements by tapping "Yes please" or "No thanks". To progress to the next placement type, tap "NEXT" at the top right hand corner of the screen.
\n\nNo personal and device data will be captured or stored.
"""
}


struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(shown: .constant(true), message: AlertView.template2) {
            print("Clicked yes")
        }
            .background(Color.titleColor)
    }
}
