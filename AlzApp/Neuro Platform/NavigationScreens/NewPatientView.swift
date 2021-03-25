//
//  NewPatientView.swift
//  Neuro Platform
//
//  Created by user175482 on 10/24/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI

// Lets you add a new patient and then starts their drawing trials
struct NewPatientView: View {
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var sex: String = "Not Selected"
    @State private var hand: String = "Not Selected"
    
    @State private var isActive : Bool = false
    @State private var showingAlert = false
    
    var body: some View {
        
        VStack {
            VStack{
                Spacer()
                Text("Patient Information").font(.system(size: 35))
                    .textStyle(TitleTextStyle())
                Spacer()
                
                HStack{
                    Text("Patient Name").font(.system(size: 25))
                    TextField("Enter Patient Name", text: $name).textFieldStyle(RoundedBorderTextFieldStyle()).border(Color.black)
                }.padding()
                HStack{
                    Text("Patient Age").font(.system(size: 25))
                    TextField("Enter Patient Age", text: $age).textFieldStyle(RoundedBorderTextFieldStyle()).border(Color.black)
                }.padding()
                
                HStack {
                    Text("Biological Sex").font(.system(size: 25))
                    VStack{
                        Picker(selection: $sex, label: Text("Sex")) {
                            Text("Male").tag("Male")
                            Text("Female").tag("Female")
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }.padding()
            }
            
            VStack {
                HStack {
                    Text("Dominant Hand").font(.system(size: 25))
                    Picker(selection: $hand, label: Text("Dominant Hand")) {
                        Text("Left Hand").tag("Left Hand")
                        Text("Right Hand").tag("Right Hand")
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                NavigationLink(destination: DrawingView(rootIsActive: $isActive, trials: 3, patient: name), isActive : $isActive) {
                    EmptyView()
                }.isDetailLink(false)
                
                Spacer()
                Button("Start Task") {
                    if(name.count > 0 &&
                        age.count > 0 &&
                        sex != "Not Selected" &&
                        hand != "Not Selected") {
                        self.isActive.toggle()
                    } else {
                        self.showingAlert.toggle()
                    }
                }.alert(isPresented: $showingAlert, content: {
                    Alert(title: Text("Form Incomplete"),
                          message: Text("Please check each entry or selection"),
                          dismissButton: .default(Text("Ok")))
                }).buttonStyle(BorderlessButtonStyle()).font(.largeTitle).padding()
                Spacer()
            }.padding()
        }
    }
}

struct NewPatientView_Previews: PreviewProvider {
    static var previews: some View {
        NewPatientView()
    }
}
