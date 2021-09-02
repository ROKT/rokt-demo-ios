//
//  HeaderView.swift
//  RoktDemo
//
//  Created by Danial Motahari on 6/4/21.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.defaultHeadingFont(.header1))
                .foregroundColor(.titleColor)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            Rectangle().foregroundColor(Color.appColor).frame(width: 34, height: 6, alignment: .center)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Demo library")
    }
}
