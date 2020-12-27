//
//  HomeView.swift
//  Neuro Platform
//
//  Created by user175482 on 10/17/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack{
            Text("Analysis Platform")
                .textStyle(TitleTextStyle())
            Button(action: {}, label: {
                Text("Take the Test")
            }).buttonStyle(MainButtonStyle())
            Button(action: {}, label: {
                Text("View Patient Records")
            }).buttonStyle(MainButtonStyle())
            Button(action: {}, label: {
                Text("Instructions Overview")
            }).buttonStyle(MainButtonStyle())
            Button(action: {}, label: {
                Text("About the App")
            }).buttonStyle(MainButtonStyle())
        }.navigationBarHidden(false)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
