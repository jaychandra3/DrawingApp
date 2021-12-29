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
    @State private var showingDuplicatePatientError = false
    @Binding var rootActive: Bool
    
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
                NavigationLink(destination: DrawingView(rootIsActive: $rootActive, trials: 3, patient: id), isActive : $drawingActive) {
                    EmptyView()
                }.isDetailLink(false)
                Spacer()
                Button("Start Task") {
                    patientID = id
                    if (patientID.count > 0 && hand != "Not Selected") {
                        let old_stored: String = defaults.string(forKey: "stored_patient_csv") ?? "ID,Dominant Hand\n"
                        let new_stored = old_stored + patientID + "," + hand + "\n"
                        defaults.set(new_stored, forKey: "stored_patient_csv")
                    
                        patientInfo = "ID: " + patientID + "\n" + "Dominant Hand: " + hand + "\n"
                        
                        var stored_patients: [String] = defaults.stringArray(forKey: "stored_patient_array") ?? [String]()
                        if (stored_patients.contains(patientID)) {
                            self.showingDuplicatePatientError = true
                            self.showingAlert = true
                        } else {
                            stored_patients.append(patientID)
                            defaults.set(stored_patients, forKey: "stored_patient_array")
                            self.drawingActive.toggle()
                        }
                        print("Stored patients: \(stored_patients)")
                    } else {
                        self.showingAlert = true
                    }
                }.alert(isPresented: $showingAlert, content: {
                    if (showingDuplicatePatientError) {
                        return Alert(title: Text("Duplicate Patient ID"),
                              message: Text("This patient ID already exists. If this is a test performed on the same patient, please label it with _ followed by the test number. (ex. _2 for the 2nd test)"), dismissButton: .default(Text("OK")))
                    } else {
                        return Alert(title: Text("Form Incomplete"),
                              message: Text("Please complete each entry or selection"),
                              dismissButton: .default(Text("OK")))
                    }
                }).buttonStyle(BorderlessButtonStyle()).font(.largeTitle).padding()
                Spacer()
            }.padding()
        }
    }
}

struct NewPatientView_Previews: PreviewProvider {
    static var previews: some View {
        NewPatientView(rootActive: Binding.constant(true))
    }
}
