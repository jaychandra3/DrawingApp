//
//  AboutAppView.swift
//  Neuro Platform
//
//  Created by user175482 on 12/28/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI

// Barebones AboutAppView : TODO
struct AboutAppView: View {
    var body: some View {
        VStack {
            Text("About the App")
                .textStyle(TitleTextStyle())
            Text("Bahoom my choom.")
                .textStyle(BodyTextStyle())
            Spacer()
        }
    }
}

struct AboutAppView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppView()
    }
}
