//
//  DrawingView.swift
//  Neuro Platform
//
//  Created by user175482 on 6/18/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI

struct DrawingView: View {
    @State private var currentDrawing : Drawing = Drawing()
    @State private var drawings : [Drawing] = [Drawing]()
    @State private var color : Color = Color.black
    @State private var lineWidth : CGFloat = 3.0
    @Binding var rootIsActive: Bool
    @State var stepList: Array<Step> = steps
    var trials : Int
    @State private var trialnum : Int = 0
    @State private var levelnum: Int = 2
    @State private var calibrationDone: Bool = false
    @State var finalShape: String = ""
    let patient : String
    @State private var data = DrawingData()
    @State private var showingAlert : Bool = false
    @State private var passedTest : Bool = true
    @State private var isAlz : Bool = true;
    @State private var threshold : CGFloat = 15
    //@EnvironmentObject var testType: TestType
    /**
     This view combines most of the needed features of drawing, collecting data, and printing the final file
     */
    
    //updates stepList based on the testType environment variable: ultimately shows different shapes if alzheimer's or parkinson's
    func changeStepList() {
        if testType == "alzheimer's" {
            stepList = steps_alz
        }
    }
    
    var body: some View {
        VStack {
            switch trialList[trialnum] {
            case .practice_screen:
                stepView(currentStep: stepList[0], data: $data)
            case .encoding_step1:
                switch levelList[levelnum] {
                case .level1:
                    stepView(currentStep: stepList[1], levelNum: levelnum, data: $data)
                case .level2:
                    stepView(currentStep: stepList[1], levelNum: levelnum, data: $data)
                case .level3:
                    stepView(currentStep: stepList[1], levelNum: levelnum, data: $data)
                case .level4:
                    stepView(currentStep: stepList[1], levelNum: levelnum, data: $data)
                case .level5:
                    stepView(currentStep: stepList[1], levelNum: levelnum, data: $data)
                }
            case .encoding_step2:
                stepView(currentStep: stepList[2], finalShape: finalShape, data: $data)
            case .encoding_step3:
                stepView(currentStep: stepList[3], data: $data)
            case .distractor_step1:
                stepView(currentStep: stepList[4], data: $data)
            case .distractor_step2:
                stepView(currentStep: stepList[5], data: $data)
            case .distractor_step3:
                stepView(currentStep: stepList[6], data: $data)
            case .retrieval_step1:
                stepView(currentStep: stepList[7], data: $data)
            case .multiple_choice:
                MultipleChoiceView(finalShape: finalShape)
            }
            
            Spacer()
            HStack {
                Spacer()
                
                Button(action: {
                    if (trialList[trialnum] == .practice_screen) {
                        if testType == "alzheimer's" {
                            stepList = steps_alz
                            patientInfo += "Test Type: Alzheimer's\n"
                        }
                        else {
                            patientInfo += "Test Type: Parkinson's\n"
                            isAlz = false
                        }
                    }
                    // if finishDrawing returns false, the coordinate count is 0 (no drawing has been made); return nothing (so when button is pressed, nothing will happen)
                    /*for point in data.coordinates{
                        print("X: " + point.x.description
                            + " Y: " + point.y.description)
                    }*/
                    /*for index in 0...data.coordinates.count - 1{
                        print("X: " + data.coordinates[index].x.description
                                + " Y: " + data.coordinates[index].y.description)
                    }*/
                    if !(self.data.finishDrawing(patient : self.patient, drawingName: "trial" + trialnum.description + "level" + (levelnum+1).description + ".csv")) && (trialList[trialnum] != .distractor_step1) && (trialList[trialnum] != .distractor_step2) && (trialList[trialnum] != .distractor_step3) &&
                        (trialList[trialnum] != .multiple_choice) {
                        // toggle showingAlert so that the alert message pops up when necessary
                        self.showingAlert.toggle()
                        return
                    }
                    
                    /*for point in self.data.coordinates{
                        print("X: " + point.x.description
                            + " Y: " + point.y.description)
                    }*/
                    // increment levelnum if we're inside encoding step 1
                    estep1: if trialList[trialnum] == .encoding_step1 {
                        // 1. Evaluate the level
                        // TODO: Add the implementation for evaluation. Currently a simulation
                        var currentLevel: Level = stepList[1].levels[levelnum]
                        let EC : ErrorCalc = ErrorCalc(isAlz: isAlz, level: levelnum+1, data: self.data)
                        let patient_error : CGFloat = EC.calcError()
                        patientInfo += "Level \(currentLevel.levelLabel.suffix(1)) \(currentLevel.levelShape)" + " Error: " + patient_error.description + "\n"
                        if (patient_error > threshold || !EC.drawingComplete()) {
                            passedTest = false
                        }
                        if (passedTest) {
                            print("PASSED TEST!!! :)")
                        }
                        else {
                            print("FAILED TEST!!! :(")
                        }
                        currentLevel.evaluateLevel(passedTest: self.passedTest)
                        self.data.coordinates.removeAll()
                        passedTest = true

                        stepList[1].levels[levelnum] = currentLevel // Update the stepList data
                        print("current level: \(currentLevel.levelLabel)")
                        
                        // 2. Proceed to display according to evaluation results
                        if (currentLevel.passedTest!) {
                            // Halt at level 5, 2 and 1
                            if (levelnum == 4 || levelnum == 1 || levelnum == 0) {
                                finalShape = currentLevel.levelShape
                                patientInfo += "Final Level: level \(currentLevel.levelLabel.suffix(1)) " +  finalShape + "\n"
                                calibrationDone.toggle()
                                break estep1
                            } else {
                                levelnum += 1
                            }
                        } else {
                            if levelnum == 0 {
                                finalShape = currentLevel.levelShape
                                patientInfo += "Final Level: level \(currentLevel.levelLabel.suffix(1)) " +  finalShape + "\n"
                                calibrationDone.toggle()
                                break estep1
                            } else {
                                // If the lower step has already passed, halt at lower step
                                let lowerLevel = stepList[1].levels[levelnum - 1]
                                if (lowerLevel.passedTest ?? false) {
                                    finalShape = lowerLevel.levelShape
                                    patientInfo += "Final Level: level \(currentLevel.levelLabel.suffix(1)) " +  finalShape + "\n"
                                    calibrationDone.toggle()
                                    break estep1
                                } else {
                                    levelnum -= 1
                                }
                            }
                        }
                    }
                    
                    // Only increase trial if calibration is complete or if it is not .encoding_step1
                    if (calibrationDone || trialList[trialnum] != .encoding_step1) {
                        trialnum += 1
                        if trialnum >= trialList.count {
                            self.rootIsActive.toggle()
    //                        avoid OOB
                            trialnum -= 1
                        } else {
                            self.drawings = [Drawing]()
                            self.data = DrawingData()
                        }
                    }
                }, label: {
                    if trialnum < trialList.count - 1 { //checks if there's still more trials left
                        Text("Next Trial").foregroundColor(.white)
                    } else {
                        Text("Finish TeHst").foregroundColor(.white)
                    }
                }).alert(isPresented: $showingAlert, content: {
                    Alert(title: Text("No Drawing"), message: Text("Please follow the instructions and perform the drawing task to the best of your ability"), dismissButton: .default(Text("OK")))
                }).buttonStyle(MainButtonStyle())
            }
            Spacer()
        }.navigationBarHidden(true)
        .navigationTitle("Trial " + (trialnum + 1).description + "/" + trials.description)
    }
}

struct DrawingView_Previews: PreviewProvider {
    @State static var value = true
    static var previews: some View {
        Group {
            DrawingView(rootIsActive: $value, trials: 3, patient: "Elias")
            DrawingView(rootIsActive: $value, trials: 3, patient: "Elias")
        }
    }
}
