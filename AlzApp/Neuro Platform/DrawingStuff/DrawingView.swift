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
            //self.changeStepList()
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
                MultipleChoiceView(finalShape:$finalShape, numAnswers:1)
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
                    if (trialList[trialnum] == .practice_screen) {
                        if testType == "alzheimer's" {
                            stepList = steps_alz
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
                        let patient_error : CGFloat = calcError(isAlz: false, level: levelnum+1, data: self.data)
                        if (patient_error > threshold || !drawingComplete(isAlz: false, level: levelnum+1, data: self.data)) {
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
                        
                        /*
                        if (levelnum == 2) { // Level 3: Prism
                            currentLevel.evaluateLevel(passedTest: false)
                        } else if (levelnum == 3) { // Level 4: Arch Spiral
                            currentLevel.evaluateLevel(passedTest: false)
                        } else if (levelnum == 4) { // Level 5: Unknown
                            currentLevel.evaluateLevel(passedTest: false)
                        } else if (levelnum == 1) { // Level 2: Infinity
                            currentLevel.evaluateLevel(passedTest: false)
                        } else if (levelnum == 0) { // Level 1: Circle
                            currentLevel.evaluateLevel(passedTest: true)
                        } // Expected final level is 1 (levelnum = 0) Circle
                        */

                        stepList[1].levels[levelnum] = currentLevel // Update the stepList data
                        print("current level: \(currentLevel.levelLabel)")
                        
                        // 2. Proceed to display according to evaluation results
                        if (currentLevel.passedTest!) {
                            // Halt at level 5, 2 and 1
                            if (levelnum == 4 || levelnum == 1 || levelnum == 0) {
                                finalShape = currentLevel.levelShape
                                patientInfo += "Final Shape: " + finalShape + "\n"
                                calibrationDone.toggle()
                                break estep1
                            } else {
                                levelnum += 1
                            }
                        } else {
                            if levelnum == 0 {
                                finalShape = currentLevel.levelShape
                                patientInfo += "Final Shape: " + finalShape + "\n"
                                calibrationDone.toggle()
                                break estep1
                            } else {
                                // If the lower step has already passed, halt at lower step
                                let lowerLevel = stepList[1].levels[levelnum - 1]
                                if (lowerLevel.passedTest ?? false) {
                                    finalShape = lowerLevel.levelShape
                                    patientInfo += "Final Shape: " + finalShape + "\n"
                                    calibrationDone.toggle()
                                    break estep1
                                } else {
                                    levelnum -= 1
                                }
                            }
                        }
                        
                        // set keeps track of the levelnums we already visited
//                        var set = Set<Int>()
//                        while (!calibrationDone && levelnum < stepList[1].levels.count) {
//                            // need to toggle passedTest parameter using shape-evaluating function
//                            // 1. Evaluate the level
//                            var currentLevel: Level = stepList[1].levels[levelnum]
//                            if (levelnum == 2) {
//                                currentLevel.evaluateLevel(passedTest: true)
//                            } else if (levelnum == 3) {
//                                currentLevel.evaluateLevel(passedTest: false)
//                            } // Expected final level is 3 (levelnum = 2)
//
//                            print("current level: \(currentLevel.levelLabel) - \(currentLevel.passedTest!)")
//
//                            // 2. Proceed to the next page based on passedTest
//                            if currentLevel.passedTest! {
//                                levelnum += 1
//                                // if levelnum already present in set, calibration process is done
//                                if (!set.insert(levelnum).0) {
//                                    self.calibrationDone.toggle()
//                                }
//                                set.insert(levelnum)
//                            } else {
//                                levelnum -= 1
//                                if (!set.insert(levelnum).0) {
//                                    self.calibrationDone.toggle()
//                                }
//                                set.insert(levelnum)
//                            }
//                        }
//
//                        self.finalShape = stepList[1].levels[set.max()!].levelShape
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

func calcError(isAlz: Bool, level: Int, data: DrawingData) -> CGFloat{
    var min_error : CGFloat = 0
    var total_error : CGFloat = 0
    var avg_error : CGFloat = 0
    var count : CGFloat = 0
    var error_arr : [CGFloat] = [CGFloat]()
    let circle_center : CGPoint = CGPoint(x: 500, y: 247) // large circle
    let circle_radius : CGFloat = 200
    let spiral_center : CGPoint = CGPoint(x: 500, y: 250)
    let infinity_center : CGPoint = CGPoint(x: 500, y: 250)
    
    for point in data.coordinates{
        print("X: " + point.x.description + " Y: " + point.y.description)
        
        // Distance to Spiral
        if (!isAlz && level == 4) {
        // center everything at (0,0)
        let norm_point : CGPoint = CGPoint(x: point.x-spiral_center.x, y: point.y-spiral_center.y)
            if(norm_point.x*norm_point.x+norm_point.y+norm_point.y < 2000) {
                error_arr.append(sqrt(norm_point.x*norm_point.x + norm_point.y*norm_point.y))
            }
            print("X': " + norm_point.x.description + " Y': " + norm_point.y.description)
            // distance to theta-based projection onto spiral
            let theta : CGFloat = calcTheta(p: norm_point)
            let nearest_ring : CGFloat = CGFloat(Int(sqrt(norm_point.x*norm_point.x + norm_point.y*norm_point.y) / (14*2*CGFloat.pi)))
            print("nearest ring: " + nearest_ring.description)
            let theta1 : CGFloat = theta + 2*CGFloat.pi*nearest_ring
            let theta2 : CGFloat = theta1 + 2*CGFloat.pi
            print("theta: " + theta.description)
            var projected_radius : CGFloat = 14*theta1
            error_arr.append(abs(sqrt(norm_point.x*norm_point.x + norm_point.y*norm_point.y) - projected_radius))
            projected_radius = 14*theta2
            error_arr.append(abs(sqrt(norm_point.x*norm_point.x + norm_point.y*norm_point.y) - projected_radius))
            if (nearest_ring >= 1) {
                let theta3 : CGFloat = theta1 - 2*CGFloat.pi
                projected_radius = 14*theta3
                error_arr.append(abs(sqrt(norm_point.x*norm_point.x + norm_point.y*norm_point.y) - projected_radius))
            }
        }
        
        // Distance to Infinity Symbol
        if (!isAlz && level == 2) {
            print("infinity")
        
            let norm_point : CGPoint = CGPoint(x: point.x-infinity_center.x, y: infinity_center.y-point.y)
            print("X': " + norm_point.x.description + " Y': " + norm_point.y.description)
            
             // one error is distance to theta-based projection onto infinity
            let theta : CGFloat = calcTheta(p: norm_point)
            let projected_radius : CGFloat = sqrt(2.2*200*2.2*200*cos(2*theta))
            
            // if point is within a circle with radius 370
            // another error is distance to form of parabola y = -(1/500)x(x-500)
            if (norm_point.x*norm_point.x + norm_point.y*norm_point.y <= 136900 || norm_point.x*norm_point.x + norm_point.y*norm_point.y - projected_radius < 0) {
                if (norm_point.x >= 0 && norm_point.y >= 0) {
                    error_arr.append(distanceToParabola(p: norm_point, a: -0.002, b: 1.1, c: 0))
                }
                else if (norm_point.x < 0 && norm_point.y >= 0) {
                    error_arr.append(distanceToParabola(p: norm_point, a: -0.002, b: -1.1, c: 0))
                }
                else if (norm_point.x < 0 && norm_point.y < 0) {
                    error_arr.append(distanceToParabola(p: norm_point, a: 0.002, b: 1.1, c: 0))
                }
                else {
                    error_arr.append(distanceToParabola(p: norm_point, a: 0.002, b: -1.1, c: 0))
                }
            }
  
            if (norm_point.x*norm_point.x + norm_point.y*norm_point.y - projected_radius >= 0) {
                error_arr.append(abs(sqrt(norm_point.x*norm_point.x + norm_point.y*norm_point.y) - projected_radius))
            }
        
        }
        // Distance to Large Circle
        if (level == 1) {
            print("large circle")
            error_arr.append(abs(sqrt((point.x-circle_center.x)*(point.x-circle_center.x) + (point.y-circle_center.y)*(point.y-circle_center.y)) - circle_radius))
        }
        
        // Distance to Large Prism (Parkinson lvl 3)
        if (!isAlz && level == 3) {
            print("prism")
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 250, y: 350), and: CGPoint(x: 250, y: 150)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 250, y: 150), and: CGPoint(x: 320, y: 60)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 320, y: 60), and: CGPoint(x: 720, y: 60)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 720, y: 60), and: CGPoint(x: 720, y: 260)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 720, y: 260), and: CGPoint(x: 650, y: 350)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 650, y: 350), and: CGPoint(x: 650, y: 150)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 650, y: 150), and: CGPoint(x: 720, y: 60)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 720, y: 60), and: CGPoint(x: 650, y: 150)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 650, y: 150), and: CGPoint(x: 250, y: 150)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 250, y: 150), and: CGPoint(x: 250, y: 350)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 250, y: 350), and: CGPoint(x: 650, y: 350)))
        }
        
        // Distance to Small Circle (in Alz)
        if (isAlz && level >= 2 && level <= 4) {
            error_arr.append(abs(sqrt((point.x-250)*(point.x-250) + (point.y-447)*(point.y-447)) - circle_radius))
        }
     
        // Distance to Triangle
        if (isAlz && level >= 2 && level <= 4) {
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 650, y: 450), and: CGPoint(x: 550, y: 600)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 550, y: 600), and: CGPoint(x: 750, y: 600)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 750, y: 600), and: CGPoint(x: 650, y: 450)))
        }
        
        // Distance to Rectangle
        if (isAlz && level == 3) {
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 650, y: 350), and: CGPoint(x: 250, y: 350)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 250, y: 350), and: CGPoint(x: 250, y: 550)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 250, y: 550), and: CGPoint(x: 650, y: 550)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 650, y: 550), and: CGPoint(x: 650, y: 350)))
        }

        // Distance to Small Prism (in Alz)
        if (isAlz && level == 4){
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 250, y: 550), and: CGPoint(x: 250, y: 350)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 250, y: 350), and: CGPoint(x: 320, y: 260)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 320, y: 260), and: CGPoint(x: 720, y: 260)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 720, y: 260), and: CGPoint(x: 720, y: 460)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 720, y: 460), and: CGPoint(x: 650, y: 550)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 650, y: 550), and: CGPoint(x: 650, y: 350)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 650, y: 350), and: CGPoint(x: 720, y: 260)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 720, y: 260), and: CGPoint(x: 650, y: 350)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 650, y: 350), and: CGPoint(x: 250, y: 350)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 250, y: 350), and: CGPoint(x: 250, y: 550)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 250, y: 550), and: CGPoint(x: 650, y: 550)))
        }
        
        // Calculate min distance to overall figure
        min_error = error_arr.min() ?? -1
        print("Error: " + min_error.description)
        total_error += min_error
        error_arr.removeAll()
        count+=1
    }
    avg_error = total_error/count
    print("Avg Error: " + avg_error.description)
    print("--------------------------------------------------")
    return avg_error
}

// ensures that the subject can't "cheat" by not tracing the whole figure
// each "zone" is a key point on the figure that the tracing must pass by
func drawingComplete(isAlz: Bool, level: Int, data: DrawingData) -> Bool {
    var zones : [CGPoint] = []
    let radius : CGFloat = 35 // have different radii for diff figures?
    // Check Spiral
    if (!isAlz && level == 4) {
        zones.append(CGPoint(x: 500, y: 250))
        zones.append(CGPoint(x: 500, y: 184.027))
        zones.append(CGPoint(x: 500, y: 359.956))
        zones.append(CGPoint(x: 500, y: 96.062))
        zones.append(CGPoint(x: 500, y: 447.920))
        zones.append(CGPoint(x: 456.018, y: 250))
        zones.append(CGPoint(x: 587.966, y: 250))
        zones.append(CGPoint(x: 368.053, y: 250))
        zones.append(CGPoint(x: 675.929, y: 250))
        zones.append(CGPoint(x: 368.053, y: 250))
        zones.append(CGPoint(x: 280.089, y: 250))
        zones.append(CGPoint(x: 763.894, y: 250))
    }
    
    // Check Infinity Symbol
    if (!isAlz && level == 2) {
        zones.append(CGPoint(x: 500, y: 250))
        zones.append(CGPoint(x: 940, y: 250))
        zones.append(CGPoint(x: 60, y: 250))
        zones.append(CGPoint(x: 769.627, y: 405.563))
        zones.append(CGPoint(x: 230.373, y: 405.563))
        zones.append(CGPoint(x: 769.627, y: 94.437))
        zones.append(CGPoint(x: 230.373, y: 94.437))
    }
    
    // Check Large Circle
    if (level == 1) {
        zones.append(CGPoint(x: 700, y: 247))
        zones.append(CGPoint(x: 300, y: 247))
        zones.append(CGPoint(x: 500, y: 447))
        zones.append(CGPoint(x: 500, y: 47))
        zones.append(CGPoint(x: 641.421, y: 388.421))
        zones.append(CGPoint(x: 358.579, y: 388.421))
        zones.append(CGPoint(x: 641.421, y: 105.579))
        zones.append(CGPoint(x: 358.579, y: 105.579))
    }
    
    // Check Large Prism
    if (!isAlz && level == 3) {
        zones.append(CGPoint(x: 250, y: 350))
        zones.append(CGPoint(x: 250, y: 150))
        zones.append(CGPoint(x: 320, y: 60))
        zones.append(CGPoint(x: 720, y: 60))
        zones.append(CGPoint(x: 720, y: 260))
        zones.append(CGPoint(x: 650, y: 350))
        zones.append(CGPoint(x: 650, y: 150))
        zones.append(CGPoint(x: 720, y: 60))
        zones.append(CGPoint(x: 650, y: 150))
        zones.append(CGPoint(x: 250, y: 150))
        zones.append(CGPoint(x: 250, y: 350))
        zones.append(CGPoint(x: 650, y: 350))
    }
    
    // Check Small Circle
    if (isAlz && level >= 2 && level <= 4) {
        zones.append(CGPoint(x: 450, y: 447))
        zones.append(CGPoint(x: 50, y: 447))
        zones.append(CGPoint(x: 250, y: 647))
        zones.append(CGPoint(x: 250, y: 247))
        zones.append(CGPoint(x: 391.421, y: 588.421))
        zones.append(CGPoint(x: 108.579, y: 588.421))
        zones.append(CGPoint(x: 391.421, y: 305.579))
        zones.append(CGPoint(x: 108.579, y: 305.579))
    }
 
    // Check Triangle
    if (isAlz && level >= 2 && level <= 4) {
        zones.append(CGPoint(x: 650, y: 450))
        zones.append(CGPoint(x: 550, y: 600))
        zones.append(CGPoint(x: 750, y: 600))
    }
    
    // Check Rectangle
    if (isAlz && level == 3) {
        zones.append(CGPoint(x: 650, y: 350))
        zones.append(CGPoint(x: 250, y: 350))
        zones.append(CGPoint(x: 250, y: 550))
        zones.append(CGPoint(x: 650, y: 550))
    }

    // Check Small Prism
    if (isAlz && level == 4){
        zones.append(CGPoint(x: 250, y: 550))
        zones.append(CGPoint(x: 250, y: 350))
        zones.append(CGPoint(x: 320, y: 260))
        zones.append(CGPoint(x: 720, y: 260))
        zones.append(CGPoint(x: 720, y: 460))
        zones.append(CGPoint(x: 650, y: 550))
        zones.append(CGPoint(x: 650, y: 350))
        zones.append(CGPoint(x: 720, y: 260))
        zones.append(CGPoint(x: 650, y: 350))
        zones.append(CGPoint(x: 250, y: 350))
        zones.append(CGPoint(x: 250, y: 550))
        zones.append(CGPoint(x: 650, y: 550))
    }
    
    return checkZones(data: data, zones: zones, radius: radius)
}

func checkZones(data: DrawingData, zones: [CGPoint], radius: CGFloat) -> Bool {
    var checkList = Array(repeating: false, count: zones.count)
    for point in data.coordinates {
        for index in 0...zones.count - 1{
            if (!checkList[index] && (point.x-zones[index].x)*(point.x-zones[index].x) + (point.y-zones[index].y)*(point.y-zones[index].y) <= radius*radius) {
                checkList[index] = true
            }
        }
    }
    for element in checkList {
        if (!element) {
            print("Drawing Incomplete")
            return false
        }
    }
    print("Drawing Complete")

    return true
}

// Distance from a point (p1) to line l1 l2
func distanceFromPoint(p: CGPoint, toLineSegment v: CGPoint, and w: CGPoint) -> CGFloat {
    let pv_dx = p.x - v.x
    let pv_dy = p.y - v.y
    let wv_dx = w.x - v.x
    let wv_dy = w.y - v.y

    let dot = pv_dx * wv_dx + pv_dy * wv_dy
    let len_sq = wv_dx * wv_dx + wv_dy * wv_dy
    let param = dot / len_sq

    var int_x, int_y: CGFloat // intersection of normal to vw that goes through p

    if param < 0 || (v.x == w.x && v.y == w.y) {
        int_x = v.x
        int_y = v.y
    } else if param > 1 {
        int_x = w.x
        int_y = w.y
    } else {
        int_x = v.x + param * wv_dx
        int_y = v.y + param * wv_dy
    }

    // Components of normal
    let dx = p.x - int_x
    let dy = p.y - int_y

    return sqrt(dx * dx + dy * dy)
}

// returns polar angle in radians
func calcTheta(p: CGPoint) -> CGFloat{
    var theta : CGFloat = 0
    if (p.x >= 0 && p.y >= 0) {
        theta = atan(p.y/p.x)
    }
    else if (p.x < 0) {
        theta = CGFloat.pi + atan(p.y/p.x)
    }
    else {
        theta = 2*CGFloat.pi + atan(p.y/p.x)
    }
    return theta
}

// y = ax^2 + bx + c
func distanceToParabola(p: CGPoint, a: Double, b: Double, c: Double) -> CGFloat {
    let x_coord : Double = solveCubicEquation(a: 2*a*a, b: 3*b*a, c: b*b+2*c*a-2*a*Double(p.y)+1, d: c*b-b*Double(p.y)-Double(p.x))[0]
    let y_coord : Double = a*x_coord*x_coord + b*x_coord + c
    return CGFloat(sqrt((Double(p.x)-x_coord)*(Double(p.x)-x_coord) + (Double(p.y)-y_coord)*(Double(p.y)-y_coord)))
}

// ax^3 + bx^2 + cx + d = 0, only real solutions
func solveCubicEquation(a: Double, b: Double, c: Double, d: Double) -> [Double] {
    if a == 0.0 {
        return solveQuadraticEquation(a: b, b: c, c: d)
    } else {
        // should be delete `a`
        let A = b / a
        let B = c / a
        let C = d / a
        return solveCubicEquation(A: A, B: B, C: C)
    }
}

// x^3 + Ax^2 + Bx + C = 0
func solveCubicEquation(A: Double, B: Double, C: Double) -> [Double] {
    if A == 0.0 {
        return solveCubicEquation(p: B, q: C)
    } else {
        // x = X - A/3 (completing the cubic. should be delete `Ax^2`)
        let p = B - (pow(A, 2.0) / 3.0)
        let q = C - ((A * B) / 3.0) + ((2.0 / 27.0) * pow(A, 3.0))
        let roots = solveCubicEquation(p: p, q: q)
        return roots.map { $0 - A/3.0 }
    }
}

// x^3 + px + q = 0
func solveCubicEquation(p: Double, q: Double) -> [Double] {
    let p3 = p / 3.0
    let q2 = q / 2.0
    let discriminant = pow(q2, 2.0) + pow(p3, 3.0) // D: discriminant
    if discriminant < 0.0 {
        // three possible real roots
        let r = sqrt(pow(-p3, 3.0))
        let t = -q / (2.0 * r)
        let cosphi = min(max(t, -1.0), 1.0)
        let phi = acos(cosphi)
        let c = 2.0 * cuberoot(r)
        let root1 = c * cos(phi/3.0)
        let root2 = c * cos((phi+2.0*Double.pi)/3.0)
        let root3 = c * cos((phi+4.0*Double.pi)/3.0)
        return [root1, root2, root3]
    } else if discriminant == 0.0 {
        // three real roots, but two of them are equal
        let u: Double
        if q2 < 0.0 {
            u = cuberoot(-q2)
        } else {
            u = -cuberoot(q2)
        }
        let root1 = 2.0 * u
        let root2 = -u
        return [root1, root2]
    } else {
        // one real root, two complex roots
        let sd = sqrt(discriminant)
        let u = cuberoot(sd - q2)
        let v = cuberoot(sd + q2)
        let root1 = u - v
        return [root1]
    }
}

func cuberoot(_ v: Double) -> Double {
    let c = 1.0 / 3.0
    if v < 0.0 {
        return -pow(-v, c)
    } else {
        return pow(v, c)
    }
}

// ax^2 + bx + c = 0
func solveQuadraticEquation(a: Double, b: Double, c: Double) -> [Double] {
    if a == 0.0 {
        let root = solveLinearEquation(a: b, b: c)
        return [root].filter({ !$0.isNaN })
    }

    let discriminant = pow(b, 2.0) - (4.0 * a * c) // D = b^2 - 4ac
    if discriminant < 0.0 {
        return []
    } else if discriminant == 0.0 {
        let root = -b / (2.0 * a)
        return [root]
    } else {
        let d = sqrt(discriminant)
        let root1 = (-b + d) / (2.0 * a)
        let root2 = (-b - d) / (2.0 * a)
        return [root1, root2]
    }
}

// ax + b = 0
func solveLinearEquation(a: Double, b: Double) -> Double {
    if a == 0.0 {
        return .nan
    } else {
        let root = -b / a
        return root
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
