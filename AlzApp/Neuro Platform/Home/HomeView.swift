//
//  HomeView.swift
//  Neuro Platform
//
//  Created by user175482 on 10/17/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @State var parkinsonsTestActive : Bool = false
    @State var alzheimersTestActive: Bool = false
    @State var recordsActive : Bool = false
    @State var instructionsActive : Bool = false
    @State var aboutAppActive : Bool = false
    @State var testType: String = ""
    
    var body: some View {
        VStack{
            // These buttons link to the various screens
            // Take inspiration if new screens needed
            // be weary of the viewActive booleans, can
            // lead to strange behavior if mistreated
            // Note: these are EmpytViews so these links
            // are only semantic (invisible to user)
            NavigationLink(
                destination: NewPatientView(rootActive: $parkinsonsTestActive, test: $testType),
                isActive: $parkinsonsTestActive,
                label: {
                    EmptyView()
                })
            NavigationLink(
                destination: NewPatientView(rootActive: $alzheimersTestActive, test: $testType),
                isActive: $alzheimersTestActive,
                label: {
                    EmptyView()
                })
            NavigationLink(
                destination: FileManagerView(),
                isActive: $recordsActive,
                label: {
                    EmptyView()
                })
            NavigationLink(
                destination: InstructionsView(),
                isActive: $instructionsActive,
                label: {
                    EmptyView()
                })
            NavigationLink(
                destination: AboutAppView(),
                isActive: $aboutAppActive,
                label: {
                    EmptyView()
                })
            
            
            // Define actual user seen interface
            // deal with styles and stuff here
            Text("Analysis Platform")
                .textStyle(TitleTextStyle())
            Group {
                Button(action: {parkinsonsTestActive.toggle(); testType = "parkinsons"}, label: {
                    Text("Take the Parkinson's Test")
                }).buttonStyle(MainButtonStyle())
                
                Button(action: {alzheimersTestActive.toggle(); testType = "alzheimers"}, label: {
                    Text("Take the Alzheimer's Test")
                }).buttonStyle(MainButtonStyle())
                
                Button(action: {recordsActive.toggle()}, label: {
                    Text("View Patient Records")
                }).buttonStyle(MainButtonStyle())
                
                Button(action: {instructionsActive.toggle()}, label: {
                    Text("Instructions Overview")
                }).buttonStyle(MainButtonStyle())
                
                Button(action: {aboutAppActive.toggle()}, label: {
                    Text("About the App")
                }).buttonStyle(MainButtonStyle())
            }
            
        }.navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
