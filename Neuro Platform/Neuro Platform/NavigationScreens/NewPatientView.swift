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
    
    var body: some View {
        VStack {
            Spacer()
            Text("Patient Name")
            TextField("Enter Patient Name", text: $name)
            NavigationLink(destination: DrawingView(rootIsActive: $isActive, patient: name), isActive : $isActive) {
                EmptyView()
            }.isDetailLink(false)
            Button("Start Task") {
                self.isActive.toggle()
            }
            Spacer()
        }.navigationBarTitle("New Patient")
    }
}

struct NewPatientView_Previews: PreviewProvider {
    static var previews: some View {
        NewPatientView()
    }
}
