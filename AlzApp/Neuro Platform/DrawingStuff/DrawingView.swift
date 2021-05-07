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
    let patient : String
    @State private var data = DrawingData()
    @State private var showingAlert : Bool = false
    @State private var pass : Bool = true
    @State private var threshold : CGFloat = 50
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
                    
                    let patient_error : CGFloat = calcError(level: 1, data: self.data)
                    if patient_error > threshold{
                        pass = false
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

func arrayMin(arr: [CGFloat]) -> CGFloat{
    var min : CGFloat = CGFloat.greatestFiniteMagnitude
    for val in arr{
        if val < min{
            min = val
        }
    }
    return min
}

// returns coordinates after translation/scaling figure
// need to figure out if it actually works like this

/*func transformPoint(p: CGPoint, center: CGPoint, x_shift: CGFloat, y_shift: CGFloat, factor: CGFloat) -> CGPoint{
    let new_p: CGPoint = CGPoint(x: factor*(p.x-center.x)+center.x+x_shift, y: factor*(p.y-center.y)+center.y+y_shift)
    return new_p
}*/

func calcError(level: Int, data: DrawingData) -> CGFloat{
    var min_error : CGFloat = 0
    var circle_error: CGFloat = 0
    var total_error : CGFloat = 0
    var avg_error : CGFloat = 0
    var count : CGFloat = 0
    var error_arr : [CGFloat] = [CGFloat]()
    let circle_center : CGPoint = CGPoint(x: 340, y: 237)
    let circle_radius : CGFloat = 200
    
    for point in data.coordinates{
        print("X: " + point.x.description
                + " Y: " + point.y.description)
        
        // Distance to Circle
        if (level <= 4) {
            circle_error = abs(sqrt((point.x-circle_center.x)*(point.x-circle_center.x) + (point.y-circle_center.y)*(point.y-circle_center.y)) - circle_radius)
            error_arr.append(circle_error)
        }
        
        // Distance to Triangle
        if (level >= 2 && level <= 4) {
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 740, y: 240), and: CGPoint(x: 640, y: 390)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 640, y: 390), and: CGPoint(x: 840, y: 390)))
            error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 840, y: 390), and: CGPoint(x: 740, y: 240)))
        }

        // Distance to Prism
        if (level == 4){
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
        min_error = arrayMin(arr: error_arr)
        print("Error: " + min_error.description)
        total_error += min_error
        error_arr.removeAll()
        count+=1
    }
    avg_error = total_error/count
    print("Avg Error: " + avg_error.description)
    return avg_error
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
