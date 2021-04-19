//
//  FeatureWalkthroughScreen.swift
//  RoktDemo
//
//  Created by Danial Motahari on 19/4/21.
//

import SwiftUI
import Rokt_Widget

struct FeatureWalkthroughScreen: View {
    let model: DefaultPlacementExamplesModel
    let selectedScreen: Int
    var screen: ScreenModel { model.screens[selectedScreen]}
    let roktEmbedded = RoktEmbeddedSwiftUIView()
    
    @State private var embeddedSize: CGFloat = 0
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 10) {
                Text(model.title)
                    .font(.defaultBoldFont(.header2))
                Text(screen.description)
                    .font(.defaultFont(.text))
                Text("Preview")
                    .font(.defaultBoldFont(.header3))
                roktEmbedded
                    .background(Color.white)
                    .frame(height: self.embeddedSize, alignment: .center)
                
                
            }.padding()
        }.onAppear {
            Rokt.execute(viewName: screen.viewName, attributes: screen.attributes,
                         placements: [screen.placeholderName: roktEmbedded.embedded], onLoad: {
                            // Optional callback for when the Rokt placement loads
                         }, onUnLoad: {
                            // Optional callback for when the Rokt placement unloads
                         }, onShouldShowLoadingIndicator: {
                            // Optional callback to show a loading indicator
                         }, onShouldHideLoadingIndicator: {
                            // Optional callback to hide a loading indicator
                         },
                         onEmbeddedSizeChange: { selectedPlacement, widgetHeight in
                            embeddedSize = widgetHeight
                         })
            
        }
    }
}

struct FeatureWalkthroughScreen_Previews: PreviewProvider {
    static var previews: some View {
        FeatureWalkthroughScreen(model: DefaultPlacementExamplesModel(title: "", shortDescription: "", longDescription: "", iconURL: "", tagID: "", screens: [ScreenModel(title: "Embedded Placement (1)", description: """
The below preview shows an embedded placement without brand logos displayed. You can progress through the offers by clicking “Yes Please” or “No Thanks”.
\n\n
The placement UI can be customised to match your app, and create a native experience. This includes changing fonts, colours and multiple configurable options to alter the look and feel of the placement.

""", viewName: "testiOS", placeholderName: "Location1", type: "embedded", attributes: ["firstname":"danial", "lastname":"m",  "email":"something@example.com", "sandbox":"true", "country":"AU"])]),selectedScreen: 0)
    }
}
