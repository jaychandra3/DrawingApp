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

// Main App view, HomeView() essentially functions as the HomePage
// but having this as the parent view allows passing the navData
// to all children (including HomeView. Any Navigation parameters
// should probably also be defined here
struct MainView: View {
    @ObservedObject var NavData = NavigationMetaData()
    @StateObject var testType = TestType()
        var body: some View {
        NavigationView {
            // I believe these are the remnants of a sidebar menu
            // Probably just get rid of this as its annoying to
            // manually disable the sidebar menu during trials
            // definetely doable, just annoying
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
        .environmentObject(testType)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
