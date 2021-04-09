//
//  DemoLibraryView.swift
//  RoktDemo
//
//  Created by Danial Motahari on 6/4/21.
//

import SwiftUI

struct DemoLibraryView: View {
    
    let demo = DemoLibraryService.getDemoLibrary()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HeaderView(title: demo.demoTitle)
                
                Text(demo.demoDescription)
                    .font(.defaultFont(.text))
                
                DemoItemView(demoItemModel: demo.defaultPlacementsExamples)
                
                DemoItemView(demoItemModel: demo.customConfigurationPage)
                
                DemoItemView(demoItemModel: demo.preDefinedScreen1)
                
                DemoItemView(demoItemModel: demo.preDefinedScreen2)
                
                DemoItemView(demoItemModel: demo.preDefinedScreen3)
            }.padding()
        }.background(Color.gray3)
        .modifier(NavigationBarGray(title: ""))
    }
}

struct DemoLibraryView_Previews: PreviewProvider {
    static var previews: some View {
        DemoLibraryView()
    }
}
