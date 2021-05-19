//  NewPatientView.swift
//  Neuro Platform
//
//  Created by user175482 on 10/24/20.
//  Copyright © 2020 NDDP. All rights reserved.
//
import SwiftUI
import Combine

let defaults = UserDefaults.standard
var patientInfo: String = ""
var patientID: String = ""

// Lets you add a new patient and then starts their drawing trials
struct NewPatientView: View {
    @State var id: String = ""
    @State var age: String = ""
    @State var sex: String = "Not Selected"
    @State var hand: String = "Not Selected"
    @State private var drawingActive : Bool = false
    @State private var showingAlert = false
    @Binding var rootActive: Bool
    @Binding var test: String
    
    var body: some View {
        VStack {
            VStack{
                Spacer()
                Text("Patient Information").bold().font(.system(size: 35))
                    .textStyle(TitleTextStyle())
                Spacer()
                HStack{
                    Text("Patient ID").font(.system(size: 25))
                    TextField("Enter Patient ID", text:  $id
                    ).textFieldStyle(RoundedBorderTextFieldStyle()).border(Color.black)
                }.padding()
                /*
                HStack{
                    Text("Patient Age").font(.system(size: 25))
                    TextField("Enter Patient Age", text: $age).textFieldStyle(RoundedBorderTextFieldStyle()).border(Color.black).onReceive(Just(age)){ newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.age = filtered
                            }
                    }
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
                */
            }
            VStack {
                HStack {
                    Text("Dominant Hand").font(.system(size: 25))
                    Picker(selection: $hand, label: Text("Dominant Hand")) {
                        Text("Left Hand").tag("Left Hand")
                        Text("Right Hand").tag("Right Hand")
                        Text("Ambidextrous").tag("Ambidextrous")
                    }.pickerStyle(SegmentedPickerStyle())
                }
                NavigationLink(destination: DrawingView(rootIsActive: $rootActive, testing: $test, trials: 3, patient: id), isActive : $drawingActive) {
                    EmptyView()
                }.isDetailLink(false)
                Spacer()
                Button("Start Task") {
                    patientID = id
                    if(patientID.count > 0 && hand != "Not Selected") {
                        let old_stored: String = defaults.string(forKey: "stored_patient_csv") ?? "ID,Dominant Hand\n"
                        let new_stored = old_stored + patientID + "," + hand + "\n"
                        defaults.set(new_stored, forKey: "stored_patient_csv")
                        /*print(defaults.string(forKey: "stored_patient_csv") ?? "Error, not a string")*/
                    
                        patientInfo = "ID: " + patientID + "\n" + "Dominant Hand: " + hand + "\n"
                        
                        self.drawingActive.toggle()
                    } else {
                        self.showingAlert.toggle()
                    }
                }.alert(isPresented: $showingAlert, content: {
                    Alert(title: Text("Form Incomplete"),
                          message: Text("Please complete each entry or selection"),
                          dismissButton: .default(Text("Ok")))
                }).buttonStyle(BorderlessButtonStyle()).font(.largeTitle).padding()
                Spacer()
            }.padding()
        }
    }
}

struct NewPatientView_Previews: PreviewProvider {
    //@State var a: Bool =
    static var previews: some View {
        NewPatientView(rootActive: Binding.constant(true),
                       test: Binding.constant("alzheimers"))
    }
}
