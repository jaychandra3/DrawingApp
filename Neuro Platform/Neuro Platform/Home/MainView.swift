//
//  Home.swift
//  Neuro Platform
//
//  Created by Jay Chandra on 8/2/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import Foundation
import SwiftUI

class NavigationMetaData : ObservableObject {
    @Published var inTask = false
}

struct MainView: View {
    @ObservedObject var NavData = NavigationMetaData()
        var body: some View {
        NavigationView {
//            VStack(spacing: 30) {
//                NavigationLink(
//                    destination: HomeView(),
//                    label: {
//                        Text("Home")
//                    })
//                NavigationLink(destination : NewPatientView()) {
//                    Text("New Patient")
//                }
//                NavigationLink(destination: FileManagerView()) {
//                    Text("Files")
//                }
//            }.navigationBarTitle("Menu")
            
            HomeView()            
        }
            .environmentObject(NavData)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
