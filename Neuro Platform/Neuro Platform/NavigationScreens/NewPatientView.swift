//
//  NewPatientView.swift
//  Neuro Platform
//
//  Created by user175482 on 10/24/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI

struct NewPatientView: View {
    @State private var name: String = ""
    @State private var isActive : Bool = false
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            Text("New Patient")
                .textStyle(TitleTextStyle())
            Spacer()
            Text("Patient Name")
            TextField("Enter Patient Name", text: $name)
            NavigationLink(destination: DrawingView(rootIsActive: $isActive, trials: 3, patient: name), isActive : $isActive) {
                EmptyView()
            }.isDetailLink(false)
            Button("Start Task") {
                if(name.count > 0) {
                    self.isActive.toggle()
                } else {
                    self.showingAlert.toggle()
                }
            }.alert(isPresented: $showingAlert, content: {
                Alert(title: Text("Form Incomplete"), message: Text("Please enter a name"), dismissButton: .default(Text("Ok")))
            })
            Spacer()
        }
    }
}

struct NewPatientView_Previews: PreviewProvider {
    static var previews: some View {
        NewPatientView()
    }
}
