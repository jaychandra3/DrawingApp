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
    @State private var threshold : CGFloat = 1
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
                    if !(self.data.finishDrawing(patient : self.patient, drawingName: "trial" + trialnum.description + ".csv")) && (trialList[trialnum] != .distractor_step1) && (trialList[trialnum] != .distractor_step2) && (trialList[trialnum] != .distractor_step3) &&
                        (trialList[trialnum] != .multiple_choice) {
                        // toggle showingAlert so that the alert message pops up when necessary
                        self.showingAlert.toggle()
                        return
                    }
                    
                    // increment levelnum if we're inside encoding step 1
                    estep1: if trialList[trialnum] == .encoding_step1 {
                        // 1. Evaluate the level
                        // TODO: Add the implementation for evaluation. Currently a simulation
                        var currentLevel: Level = stepList[1].levels[levelnum]
                        let patient_error : CGFloat = calcError(isAlz: true, level: levelnum+1, data: self.data)
                        if patient_error > threshold{
                            passedTest = false
                        }
                        currentLevel.evaluateLevel(passedTest: self.passedTest)
                        
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
                                calibrationDone.toggle()
                                break estep1
                            } else {
                                levelnum += 1
                            }
                        } else {
                            if levelnum == 0 {
                                finalShape = currentLevel.levelShape
                                calibrationDone.toggle()
                                break estep1
                            } else {
                                // If the lower step has already passed, halt at lower step
                                let lowerLevel = stepList[1].levels[levelnum - 1]
                                if (lowerLevel.passedTest ?? false) {
                                    finalShape = lowerLevel.levelShape
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
//                        print(finalShape)
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

/* Distance from a point (p1) to line l1 l2 */
func distanceFromPoint(p: CGPoint, toLineSegment v: CGPoint, and w: CGPoint) -> CGFloat {
    let pv_dx = p.x - v.x
    let pv_dy = p.y - v.y
    let wv_dx = w.x - v.x
    let wv_dy = w.y - v.y

    let dot = pv_dx * wv_dx + pv_dy * wv_dy
    let len_sq = wv_dx * wv_dx + wv_dy * wv_dy
    let param = dot / len_sq

    var int_x, int_y: CGFloat /* intersection of normal to vw that goes through p */

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

    /* Components of normal */
    let dx = p.x - int_x
    let dy = p.y - int_y

    return sqrt(dx * dx + dy * dy)
}

func calcError(isAlz: Bool, level: Int, data: DrawingData) -> CGFloat{
    var min_error : CGFloat = 0
    var circle_error : CGFloat = 0
    var spiral_error : CGFloat = 0
    var total_error : CGFloat = 0
    var avg_error : CGFloat = 0
    var count : CGFloat = 0
    var error_arr : [CGFloat] = [CGFloat]()
    let circle_center : CGPoint = CGPoint(x: 340, y: 237)
    let circle_radius : CGFloat = 200
    let spiral_center : CGPoint = CGPoint(x: 400, y: 385)
    let lemniscate_center : CGPoint = CGPoint(x: 400, y: 385)
    
    for point in data.coordinates{
        print("X: " + point.x.description
                + " Y: " + point.y.description)
        
        // Distance to Spiral
        if (!isAlz && level == 4) {
            // center everything at (0,0)
            let norm_point : CGPoint = CGPoint(x: point.x-spiral_center.x, y: point.y-spiral_center.y)
            
            // distance to theta-based projection onto spiral
            var theta : CGFloat = calcTheta(p: norm_point)
            let nearest_ring : CGFloat = CGFloat((sqrt(norm_point.x)*(norm_point.x) + (norm_point.y)*(norm_point.y) / (16.8*2*CGFloat.pi)).rounded())
            theta += 2*CGFloat.pi*nearest_ring
            let corresp_point : CGPoint = CGPoint(x: spiral_center.x + 16.8*cos(theta)*theta, y: spiral_center.y + 16.8*sin(theta)*theta)
            let corresp_radius : CGFloat = sqrt(16.8*cos(theta)*theta*16.8*cos(theta)*theta + 16.8*sin(theta)*theta*16.8*sin(theta)*theta)
            spiral_error = abs(sqrt((point.x-corresp_point.x)*(point.x-corresp_point.x) + (point.y-corresp_point.y)*(point.y-corresp_point.y)) - corresp_radius)
            error_arr.append(spiral_error)
        }
        
        // Distance to Lemniscate (Infinity Symbol)
        if (!isAlz && level == 2) {
            let norm_point : CGPoint = CGPoint(x: point.x-lemniscate_center.x, y: point.y-lemniscate_center.y)
            if (sqrt(norm_point.x*norm_point.x + norm_point.y*norm_point.y) < 50) {
                // error is distance to closest of asymptotic lines
                error_arr.append(distanceFromPoint(p: norm_point, toLineSegment: CGPoint(x: -50, y: -50), and: CGPoint(x: 50, y: 50)))
                error_arr.append(distanceFromPoint(p: norm_point, toLineSegment: CGPoint(x: -50, y: 50), and: CGPoint(x: 50, y: -50)))
            }
            else { // error is distance to theta-based projection onto lemniscate
                var _ : CGFloat = calcTheta(p: norm_point)
            }
        }
        
        // Distance to Circle
        if (level == 1 || isAlz && level <= 4) {
            circle_error = abs(sqrt((point.x-circle_center.x)*(point.x-circle_center.x) + (point.y-circle_center.y)*(point.y-circle_center.y)) - circle_radius)
            error_arr.append(circle_error)
        }
        
        // Distance to Triangle
        if (isAlz && level >= 2 && level <= 4) {
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 740, y: 240), and: CGPoint(x: 640, y: 390)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 640, y: 390), and: CGPoint(x: 840, y: 390)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 840, y: 390), and: CGPoint(x: 740, y: 240)))
        }

        // Distance to Prism
        if (!isAlz && level == 3 || isAlz && level == 4){
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 340, y: 340), and: CGPoint(x: 340, y: 140)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 340, y: 140), and: CGPoint(x: 410, y: 50)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 410, y: 50), and: CGPoint(x: 810, y: 50)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 810, y: 50), and: CGPoint(x: 810, y: 250)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 810, y: 250), and: CGPoint(x: 740, y: 340)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 740, y: 340), and: CGPoint(x: 740, y: 140)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 740, y: 140), and: CGPoint(x: 810, y: 50)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 810, y: 50), and: CGPoint(x: 740, y: 140)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 740, y: 140), and: CGPoint(x: 310, y: 140)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 310, y: 140), and: CGPoint(x: 340, y: 340)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 340, y: 340), and: CGPoint(x: 740, y: 340)))
        }
        
        // Calculate min distance to overall figure
        min_error = error_arr.min() ?? 0
        print("Error: " + min_error.description)
        total_error += min_error
        error_arr.removeAll()
        count+=1
    }
    avg_error = total_error/count
    print("Avg Error: " + avg_error.description)
    return avg_error
}

// returns polar angle in radians
func calcTheta(p: CGPoint) -> CGFloat{
    var theta : CGFloat = 0
    if (p.x >= 0 && p.y >= 0) {
        theta = atan(p.x/p.y)
    }
    else if (p.x < 0) {
        theta = CGFloat.pi + atan(p.x/p.y)
    }
    else {
        theta = 2*CGFloat.pi + atan(p.x/p.y)
    }
    return theta
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
