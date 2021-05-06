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
    var trials : Int
    @State private var trialnum : Int = 0
    @State private var levelnum: Int = 3
    @State private var calibrationDone: Bool = false
    @State var finalShape: String = ""
    let patient : String
    @State private var data = DrawingData()
    @State private var showingAlert = false
    /**
     This view combines most of the needed features of drawing, collecting data, and printing the final file
     */
    var body: some View {
        VStack {
            /*
//                    Prompt type
            switch trialList[trialnum].0 { //accesses the first index's first object
            case .fast:
                Text("Fast")
                    .textStyle(TitleTextStyle())
            case .accurate:
                Text("Accurate")
                    .textStyle(TitleTextStyle())
            }
            
            ZStack {
                DrawingPad(currentDrawing: $currentDrawing,
                           drawings: $drawings)
                HStack {
                    Spacer()
                    
//                    Shape type
                    switch trialList[trialnum].1 { //accesses the first index's second object
                    
                    case .circle:
                        Circle().stroke(lineWidth:3).opacity(0.5)
                        Rectangle().stroke(lineWidth:3).opacity(0.5)
                            .frame(width: 200, height: 200)
                    case .spirosquare:
                        SpiroSquare().stroke(lineWidth:3).opacity(0.5)
                    case .rectangle:
                        Rectangle().stroke(lineWidth:3).opacity(0.5)
                            .frame(width: 200, height: 200)
                    case .multipleshapes:
                        MultipleShapes().stroke(lineWidth:3)
                            .opacity(0.5)
                    case .archspiral:
                        ArchSpiral().stroke(lineWidth:3)
                            .opacity(0.5)
                    }
                    
                    Spacer()
                }
                
                TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data)
                    .opacity(0.1)
            }
            */
            switch trialList[trialnum] {
            case .practice_screen:
                stepView(currentStep: stepList[0], data: $data)
            /*
            case .animation_screen:
                stepView(currentStep: stepList[1], data: nil)
            */
            case .encoding_step1:
                stepView(currentStep: stepList[2], data: $data)
            case .encoding_step2:
                stepView(currentStep: stepList[3], data: $data)
            case .encoding_step3:
                stepView(currentStep: stepList[4], data: $data)
            case .distractor_step:
                stepView(currentStep: stepList[5], data: $data)
            case .retrieval_step1:
                stepView(currentStep: stepList[6], data: $data)
            case .retrieval_step2:
                stepView(currentStep: stepList[7], data: $data)
            case .multiple_choice:
                QuestionsView()
            }
            
            Spacer()
            HStack {
//                DELETE LATER, NOT NEEDED FOR FINAL VERSION
//                Clears current drawing
                Button(action: {self.drawings = [Drawing]()}, label: {
                    Text("Clear Drawing")
                }).buttonStyle(MainButtonStyle())
                
                // this is an attempt to change the navigation link to the home page after we click finish test (doesn't work)
                // need to change!
                NavigationLink(destination: HomeView(), isActive: $rootIsActive) {
                    EmptyView()
                }.isDetailLink(false)
                
                Spacer()
                
                Button(action: {
                    // if finishDrawing returns false, the coordinate count is 0 (no drawing has been made); return nothing (so when button is pressed, nothing will happen)
                    if !(self.data.finishDrawing(patient : self.patient, drawingName: "trial" + trialnum.description + ".csv")) && (trialList[trialnum] != .distractor_step) &&
                        (trialList[trialnum] != .multiple_choice) {
                        // toggle showingAlert so that the alert message pops up when necessary
                        self.showingAlert.toggle()
                        return
                    }
                    
                    // increment levelnum if we're inside encoding step 1
                    if trialList[trialnum] == .encoding_step1 {
                        // set keeps track of the levelnums we already visited
                        var set = Set<Int>()
                        set.insert(levelnum)
                        while (!calibrationDone) {
                            // need to toggle passedTest parameter using shape-evaluating function
                            if stepList[1].levels[levelnum].passedTest {
                                levelnum += 1
                                // if levelnum already present in set, calibration process is done
                                if (!set.insert(levelnum).0) {
                                    self.calibrationDone.toggle()
                                }
                                set.insert(levelnum)
                            } else {
                                levelnum -= 1
                                if (!set.insert(levelnum).0) {
                                    self.calibrationDone.toggle()
                                }
                                set.insert(levelnum)
                            }
                        }
                        
                        var maxLevel: Int = 0
                        for number in set {
                            if number > maxLevel { maxLevel = number }
                        }
                    
                        finalShape = stepList[1].levels[maxLevel].levelLabel
                    }
                    
                    trialnum += 1
                    if trialnum >= trialList.count {
                        self.rootIsActive.toggle()
//                        avoid OOB
                        trialnum -= 1
                    } else {
                        self.drawings = [Drawing]()
                        self.data = DrawingData()
                    }
                }, label: {
                    if trialnum < trialList.count - 1 { //checks if there's still more trials left
                        Text("Next Trial").foregroundColor(.white)
                    } else {
                        Text("Finish Test").foregroundColor(.white)
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
