//
//  ContentView.swift
//  RoktDemo
//
//  Copyright 2020 Rokt Pte Ltd
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import SwiftUI
import MessageUI

struct HomePageView: View {
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isEmailShown = false
    @State var isEmailAlertShown = false
    @State private var previewParameter: String?
    @EnvironmentObject var appState: AppState
    @State private var navigateToLayoutDemo = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                Color.white.edgesIgnoringSafeArea(.all)
                
                SettingButton()
                
                VStack {
                    
                    Spacer()
                    VStack {
                        HStack {
                            Image("RoktLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, alignment: .center)
                            
                        }
                        Text("Seize the Transaction Moment")
                            .font(.defaultFont(.header3))
                            .foregroundColor(.titleColor)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    Spacer()
                    VStack(spacing: 15) {
                        NavigationLink(
                            destination: DemoLibraryView(viewModel: DemoLibraryViewModel()),
                            label: {
                                Text("Placement library")
                            })
                        .buttonStyle(ButtonDefaultOutlined())
                        .navigationBarTitle(Text(""))
                        
                        NavigationLink(
                            destination: LayoutDemoView(viewModel: LayoutDemoViewModel()),
                            label: {
                                Text("Layout library in SwiftUI")
                            })
                        .buttonStyle(ButtonDefaultOutlined())
                        .navigationBarTitle(Text(""))
                        
                        NavigationLink(
                            destination: LayoutDemoUiViewControllerWrapper(localAppState: appState),
                            label: {
                                Text("Layout library in UIKit")
                            })
                        .buttonStyle(ButtonDefaultOutlined())
                        .navigationBarTitle(Text(""))
                        
                        NavigationLink(
                            destination: AboutRoktView(viewModel: AboutRoktViewModel()),
                            label: {
                                Text("About this app")
                            })
                        .buttonStyle(ButtonDefault())
                        .navigationBarTitle(Text(""))
                        
                        Button(action: {
                            if MFMailComposeViewController.canSendMail() {
                                self.isEmailShown.toggle()
                            } else {
                                self.isEmailAlertShown.toggle()
                            }
                        }) {
                            Text("Contact us")
                        }
                        .buttonStyle(ButtonDefault())
                        .sheet(isPresented: $isEmailShown) {
                            EmailView(result: self.$result)
                        }.alert(isPresented: $isEmailAlertShown) {
                            Alert(title: Text("Mail Services"),
                                  message: Text("Mail services are not available. Please send us an email instead via support@rokt.com if you have any questions."),
                                  dismissButton: .default(Text("OK")))
                        }
                        
                        Text("® Rokt 2021 — All rights reserved App Version \(UIApplication.appVersion ?? "")")
                            .font(.defaultFont(.subtitle2))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.textColor)
                            .padding(.bottom)
                    }.padding()
                    
                    NavigationLink(
                        destination: LayoutDemoUiViewControllerWrapper(localAppState: appState),
                        isActive: $navigateToLayoutDemo,
                        label: {
                            EmptyView()
                        }
                    )
                }
            }
            
        }
        .background(Color.white)
        .navigationViewStyle(StackNavigationViewStyle())
        .modifier(NavigationBarTransparent(title: ""))
        .onAppear {
            if !navigateToLayoutDemo && appState.previewParameterString != nil {
                navigateToLayoutDemo = true
            }
        }
        .ifAvailableIOS14OrLater {
            if #available(iOS 14.0, *) {
                $0.onChange(of: appState.previewParameterString) { newValue in
                    if (newValue != nil) {
                        navigateToLayoutDemo = true
                    }
                }
            }
        }
    }
}

// This is the SwiftUI wrapper that makes the UIKit view controller available to SwiftUI
struct LayoutDemoUiViewControllerWrapper: UIViewControllerRepresentable {
    let localAppState: AppState
    
    func makeUIViewController(context: Context) -> LayoutDemoUIView {
        return LayoutDemoUIView(viewModel: LayoutDemoViewModel(), appState: localAppState)
    }
    
    func updateUIViewController(_ uiViewController: LayoutDemoUIView, context: Context) {
        // Update the view controller if needed
    }
}

struct SettingButton: View {
    var body: some View {
        if #available(iOS 14.0, *) {
            NavigationLink(
                destination: SettingView(),
                label: {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.black)
                        .padding(20)
                })
        } else {
            EmptyView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

extension View {
    @ViewBuilder
    func ifAvailableIOS14OrLater<Content: View>(@ViewBuilder content: (Self) -> Content) -> some View {
        if #available(iOS 14.0, *) {
            content(self)
        } else {
            self
        }
    }
}
