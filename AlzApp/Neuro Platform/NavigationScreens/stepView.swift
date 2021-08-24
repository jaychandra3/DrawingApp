//
//  stepView.swift
//  Neuro Platform
//
//  Created by Jason Shang on 3/31/21.
//  Copyright © 2021 NDDP. All rights reserved.
//
import SwiftUI
import Foundation
import CoreGraphics

struct stepView: View {
    var currentStep: Step
    var levelNum: Int?
    var finalShape: String?
    
    @State var displayDistractorView: Bool = false
    
    @State private var currentDrawing : Drawing = Drawing()
    @State private var drawings : [Drawing] = [Drawing]()
    @Binding var data: DrawingData
    
    var body: some View {
        VStack {
            VStack (alignment: .leading) {
                HStack {
                    Text(verbatim: currentStep.stepLabel).bold().font(.system(size: 35))
                    Spacer()
                }.padding(.bottom, 5)
                Text("Instructions").bold().font(.system(size: 28)).padding(.bottom, 15)
                Text(currentStep.instructions).font(.system(size: 23))
            }.padding()
            VStack {
                if currentStep.step == "practice_screen" || currentStep.step == "retrieval_step" || currentStep.step == "empty_pad_drawing" {
                    ZStack {
                        DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                        TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data).opacity(0.1)
                    }
                } else if currentStep.step == "encoding_step1" {
                    shapeView(shape: currentStep.levels[levelNum!].levelShape, data: $data)
                } else if currentStep.step == "encoding_step2" {
                    shapeView(shape: finalShape!, data: $data)
                } else if currentStep.step == "fast" {
                    shapeView(shape: finalShape!, data: $data)
                } else if currentStep.step == "encoding_step3" {
                    FinalShapePreview(shape: finalShape!, data: $data)
                } else if (currentStep.step == "encoding_step3") {
                    FinalShapePreview(shape: finalShape!, data: $data)
                }
                
                
//                else if currentStep.step == "encoding_step3" && testType == "parkinson's" {
//                    FinalShapePreview(shape: finalShape!, data: $data)
//                }
                else if currentStep.step == "distractor_step1" {
                    Spacer()
                    TimerView(displayDistractorView: $displayDistractorView).padding()
                    if displayDistractorView {
                        Distractor1View().padding()
                    }
                    Spacer()
                } else if currentStep.step == "distractor_step2" {
                    Spacer()
                    TimerView(displayDistractorView: $displayDistractorView).padding()
                    Distractor2View().padding()
                    Spacer()
                } else if currentStep.step == "distractor_step3" {
                    Spacer()
                    TimerView(displayDistractorView: $displayDistractorView).padding()
                    Distractor3View().padding()
                    Spacer()
                } else {
                    Spacer()
                    EmptyView()
                }
            }
        }
    }
}

/*
struct stepView_Previews: PreviewProvider {
    @State static var data = DrawingData()
    static var previews: some View {
        stepView(currentStep: steps[0], displayDistractorView: false, data: $data)
        stepView(currentStep: steps[1], displayDistractorView: false, data: $data)
    }
}*/

