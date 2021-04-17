//  NewPatientView.swift
//  Neuro Platform
//
//  Created by user175482 on 10/24/20.
//  Copyright © 2020 NDDP. All rights reserved.
//
import SwiftUI
import Combine
//var patientData = UserData()
// var patientCSV: NSString = "Name, Age, Sex, DominantHand\n"
let defaults = UserDefaults.standard
// Lets you add a new patient and then starts their drawing trials
struct NewPatientView: View {
    @State var name: String = ""
    @State var age: String = ""
    @State var sex: String = "Not Selected"
    @State var hand: String = "Not Selected"
    @State private var drawingActive : Bool = false
    @State private var showingAlert = false
    @Binding var rootActive: Bool
    
    var body: some View {
        VStack {
            VStack{
                Spacer()
                Text("Patient Information").bold().font(.system(size: 35))
                    .textStyle(TitleTextStyle())
                Spacer()
                HStack{
                    Text("Patient Name").font(.system(size: 25))
                    TextField("Enter Patient Name", text: $name).textFieldStyle(RoundedBorderTextFieldStyle()).border(Color.black)
                }.padding()
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
            }
            VStack {
                HStack {
                    Text("Dominant Hand").font(.system(size: 25))
                    Picker(selection: $hand, label: Text("Dominant Hand")) {
                        Text("Left Hand").tag("Left Hand")
                        Text("Right Hand").tag("Right Hand")
                    }.pickerStyle(SegmentedPickerStyle())
                }
                NavigationLink(destination: DrawingView(rootIsActive: $rootActive, trials: 3, patient: name), isActive : $drawingActive) {
                    EmptyView()
                }.isDetailLink(false)
                Spacer()
                Button("Start Task") {
                    if(name.count > 0 &&
                        age.count > 0 &&
                        sex != "Not Selected" &&
                        hand != "Not Selected") {
                        /*let newUser = Patient(name: self.name, age: self.age, sex: self.sex, hand: self.hand)
                        patientData.updateForm(newPatient : newUser)*/
                        let old_stored: String = defaults.string(forKey: "stored_patient_csv") ?? "Name,Age,Sex,Dominant Hand\n"
                        let new_stored = old_stored + name + "," + age + "," + sex + "," + hand + "\n"
                        defaults.set(new_stored, forKey: "stored_patient_csv")
                        print(defaults.string(forKey: "stored_patient_csv") ?? "Error, not a string")
                        
                        let patientInfo: String = "Name: " + name + "\n" + "Age: " + age + "\n" + "Sex: " + sex + "\n" + "Dominant Hand: " + hand + "\n"
                        finishInfo(patient: name, patientInfoCSV: patientInfo)
                        
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

func finishInfo(patient: String, patientInfoCSV: String, formName : String = "patientInfo.csv") {
    let url : URL = getDocumentsDirectory(foldername: patient, filename: formName)
    do {
    let str : String = patientInfoCSV
        try str.write(to: url, atomically: true, encoding: .utf8)
        let input = try String(contentsOf: url)
        print(input)
    } catch {
        print("Failed to write to disk")
        print(error.localizedDescription)
    }
}

struct NewPatientView_Previews: PreviewProvider {
    //@State var a: Bool =
    static var previews: some View {
        NewPatientView(rootActive: Binding.constant(true))
    }
}
