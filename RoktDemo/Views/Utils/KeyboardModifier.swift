//
//  KeyboardModifier.swift
//  RoktDemo
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/


import SwiftUI

struct KeyboardModifier: ViewModifier {
    @State private var offset: CGFloat = 0
    private let defaultPadding: CGFloat = 16
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, offset)
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                                       object: nil,
                                                       queue: .main) { notify in
                    let value = notify.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                    let height = value.height
                    let bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
                    self.offset = height - bottom + self.defaultPadding
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                                       object: nil,
                                                       queue: .main) { _ in
                    self.offset = 0
                }
            }
    }
}

extension View {
    func keyboardSafe() -> ModifiedContent<Self, KeyboardModifier> {
        return modifier(KeyboardModifier())
    }
}

