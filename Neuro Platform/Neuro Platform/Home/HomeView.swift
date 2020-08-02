//
//  Home.swift
//  Neuro Platform
//
//  Created by Jay Chandra on 8/2/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import Foundation
import SwiftUI

struct HomeView: View {
    
        var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                NavigationLink(destination: DrawingView(patient: "testPatient")) {
                    Text("Drawing Task")
                }
                
                NavigationLink(destination: FileManagerView()) {
                    Text("Files")
                }
            }
            .navigationBarTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
