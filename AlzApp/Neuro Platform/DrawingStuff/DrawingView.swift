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
    @State var trialList: Array<TrialType> = trialListParkinson
    var trials : Int
    @State private var trialnum : Int = 0
    @State private var levelnum: Int = 2
    @State private var calibrationDone: Bool = false
    @State var finalShape: String = ""
    let patient : String
    @State private var data = DrawingData()
    @State private var showingAlert : Bool = false
    @State private var passedTest : Bool = true
    @State private var isAlz : Bool = true
    @State private var threshold : CGFloat = 15*UIScreen.screenWidth/1150
    @State var answerSelected: Bool = false
    @State var showPopup: Bool = false
    //@EnvironmentObject var testType: TestType
    /**
     This view combines most of the needed features of drawing, collecting data, and printing the final file
     */
    
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
            case .fast:
                stepView(currentStep: stepList[3], finalShape: finalShape, data: $data)
            case .encoding_step3:
                if testType == "alzheimer's" {
                    stepView(currentStep: stepList[3], data: $data)
                } else {
                    stepView(currentStep: stepList[4], data: $data)
                }
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
                    print(trialList[trialnum])
                    if (trialList[trialnum] == .practice_screen) {
                        if testType == "alzheimer's" {
                            stepList = steps_alz
                            trialList = trialListAlz
                            patientInfo += "Test Type: Alzheimer's\n"
                        }
                        else {
                            patientInfo += "Test Type: Parkinson's\n"
                            isAlz = false
                        }
                    }
                    
                    if !(self.data.finishDrawing(patient : self.patient, drawingName: "trial" + trialnum.description + "level" + (levelnum+1).description + ".csv")) && (trialList[trialnum] != .distractor_step1) && (trialList[trialnum] != .distractor_step2) && (trialList[trialnum] != .distractor_step3) &&
                        (trialList[trialnum] != .multiple_choice) {
                        // toggle showingAlert so that the alert message pops up when necessary
                        self.showPopup = true // Actual alert
                        self.showingAlert = true // Drawing alert
                        return
                    }
                    
                    // Show MCQ 'No Answer' Alert
                    if (trialList[trialnum] == .multiple_choice && MCQFinalAnswer.answer == nil) {
                        self.showPopup = true
                        self.showingAlert = false
                        return
                    }
                    
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
                            if testType == "alzheimer's" {
                                let d1result: String = DistractorAnswers.step1FinalResult["result"] ?? ""
                                patientInfo += "Distractor Step 1 Results : " + d1result + "\n"
                                //let d1score: String = DistractorAnswers.step1FinalResult["score"] ?? "0"
                                //patientInfo += "Distractor Step 1 Score: " + d1score.description + "%\n"
                            
                                let d2result: String = DistractorAnswers.step2FinalResult["result"] ?? ""
                                patientInfo += "Distractor Step 2 Results : " + d2result + "\n"
                                //let d2score: String = DistractorAnswers.step2FinalResult["score"] ?? "0"
                                //patientInfo += "Distractor Step 2 Score: " + d2score.description + "%\n"
                                
                                let d3result: String = DistractorAnswers.step3FinalResult["result"] ?? ""
                                patientInfo += "Distractor Step 3 Results : " + d3result + "\n"
                                //let d3score: String = DistractorAnswers.step3FinalResult["score"] ?? "0"
                                //patientInfo += "Distractor Step 3 Score: " + d3score.description + "%\n"
                                let d3inOrder: String = DistractorAnswers.step3FinalResult["inOrder"] ?? "false"
                                patientInfo += "Distractor Step 3 InOrder: " + d3inOrder.description + "\n"
                                
                                patientInfo += "MCQ Selection: " + MCQFinalAnswer.answer!.description + "\n"
                                // assuming correct answer is always C
                                patientInfo += "MCQ Correctness: " + (MCQFinalAnswer.answer! == 3).description + "\n"
                                patientInfo += "Device Height: \(UIScreen.screenHeight)\n"
                                patientInfo += "Device Width: \(UIScreen.screenWidth)"
                                print(patientInfo)
                                MCQFinalAnswer.reset() // Resets MCQFinalAnswer struct after saving
                            }
                            self.rootIsActive.toggle()
    //                        avoid OOB
                            finishInfo(patient: patientID, patientInfoCSV: patientInfo)
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
                        Text("Finish Test").foregroundColor(.white)
                    }
                }).alert(isPresented: $showPopup, content: {
                     if (showingAlert) {
                         return Alert(title: Text("No Drawing"), message: Text("Please follow the instructions and perform the drawing task to the best of your ability"), dismissButton: .default(Text("OK"), action: {self.showPopup = false}))
                     } else {
                         return Alert(title: Text("No Answer Selected"), message: Text("Please select an answer before finishing the test"), dismissButton: .default(Text("OK")))
                     }
                }).buttonStyle(MainButtonStyle())
            }
            Spacer()
        }.navigationBarHidden(true)
        .navigationTitle("Trial " + (trialnum + 1).description + "/" + trials.description)
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

struct DrawingView_Previews: PreviewProvider {
    @State static var value = true
    static var previews: some View {
        Group {
            DrawingView(rootIsActive: $value, trials: 3, patient: "Elias")
            DrawingView(rootIsActive: $value, trials: 3, patient: "Elias")
        }
    }
}
