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
    @State private var data = DrawingData()
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text(verbatim: currentStep.stepLabel).bold().font(.system(size: 35))
                Spacer()
            }.padding(.bottom, 25)
            Text("Instructions").bold().font(.system(size: 28)).padding(.bottom, 15)
            Text(currentStep.instructions).font(.system(size: 25))
            
            if currentStep.shape == "multiple_shapes" {
                ZStack {
                    DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                    HStack {
                        Spacer()
                        MultipleShapes().stroke(lineWidth:3)
                    }
                    TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data)
                        .opacity(0.1)
                }
            } else if currentStep.shape == "multiple_shapes_vertices" {
                ZStack {
                    //DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                    HStack {
                        MultipleShapes().stroke(lineWidth:3)
                        Spacer()
                        DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                        TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data)
                            .opacity(0.1)
                    }
                }
            }
        }.padding()
    }
}

struct stepView_Previews: PreviewProvider {
    static var previews: some View {
        stepView(currentStep: stepList[0])
        stepView(currentStep: stepList[1])
    }
}
