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
    
    @State private var currentDrawing : Drawing = Drawing()
    @State private var drawings : [Drawing] = [Drawing]()
    @Binding var data: DrawingData
    
    /*
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text(verbatim: currentStep.stepLabel).bold().font(.system(size: 35))
                Spacer()
            }.padding(.bottom, 5)
            Text("Instructions").bold().font(.system(size: 28)).padding(.bottom, 15)
            Text(currentStep.instructions).font(.system(size: 23))
            
            if currentStep.shape == "multiple_shapes" {
                VStack (alignment: .leading) {
                    Text("Template: ").bold().font(.system(size:20)).padding(.top, 2)
                    MultipleShapes().stroke(lineWidth:3).scale(0.7).offset(x:-20, y:-225)
                    Divider()
                    Text("Your Drawing: ").bold().font(.system(size:20)).padding(.top, -50)
                    ZStack {
                        DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                        MultipleShapes().stroke(lineWidth:3).scale(0.75).offset(x:-20, y:-175)
                        TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data).opacity(0.1)
                    }.padding(.top, -10)
                }
            } else if currentStep.shape == "multiple_shapes_vertices" {
                VStack (alignment: .leading) {
                    Text("Template: ").bold().font(.system(size:20)).padding(.top, 2)
                    MultipleShapes().stroke(lineWidth:3).scale(0.7).offset(x:-20, y:-225)
                    Text("Your Drawing: ").bold().font(.system(size:20)).padding(.top, -50)
                    ZStack {
                        DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                        MultipleShapesVertices().stroke(lineWidth:3).scale(0.75).offset(x:-20, y:-175)
                        TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data).opacity(0.1)
                    }.padding(.top, -10)
                }
            }
        }.padding()
    }
    */
    
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
                if currentStep.shape == "multiple_shapes" {
                    VStack (alignment: .leading) {
                        Text("Template: ").bold().font(.system(size:20)).padding(.top, 2)
                        MultipleShapes().stroke(lineWidth:3).scale(0.7).offset(x:-20, y:-225)
                        Divider()
                        Text("Your Drawing: ").bold().font(.system(size:20)).padding(.top, -50)
                        ZStack {
                            DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                            MultipleShapes().stroke(lineWidth:3).scale(0.75).offset(x:-20, y:-175)
                            TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data).opacity(0.1)
                        }.padding(.top, -10)
                    }
                } else if currentStep.shape == "multiple_shapes_vertices" {
                    VStack (alignment: .leading) {
                        Text("Template: ").bold().font(.system(size:20)).padding(.top, 2)
                        MultipleShapes().stroke(lineWidth:3).scale(0.7).offset(x:-20, y:-225)
                        Text("Your Drawing: ").bold().font(.system(size:20)).padding(.top, -50)
                        ZStack {
                            DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                            MultipleShapesVertices().stroke(lineWidth:3).scale(0.75).offset(x:-20, y:-175)
                            TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data).opacity(0.1)
                        }.padding(.top, -10)
                    }
                } else if currentStep.shape == "none" {
                    ZStack {
                        DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                        TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data).opacity(0.1)
                    }
                }
            }
        }
    }
}

struct stepView_Previews: PreviewProvider {
    @State static var data = DrawingData()
    static var previews: some View {
        stepView(currentStep: stepList[0], data: $data)
        stepView(currentStep: stepList[1], data: $data)
        stepView(currentStep: stepList[2], data: $data)
    }
}

