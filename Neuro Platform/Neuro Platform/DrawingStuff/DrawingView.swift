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
    @Binding var rootIsActive : Bool
    var trials : Int
    @State private var trialnum : Int = 0
    let patient : String
    @State private var data = DrawingData()
    
    let circle : some Shape = Circle()
        .stroke(lineWidth: 3)
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                DrawingPad(currentDrawing: $currentDrawing,
                           drawings: $drawings)
                HStack {
                    Spacer()
                    circle
                        .opacity(0.5)
                    Spacer()
                }
                
                TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data)
                    .opacity(0.1)
                
            }
            Spacer()
            HStack {
                Button(action: {self.drawings = [Drawing]()}) {
                    Text("Clear Drawings").foregroundColor(.white)
                }
                Spacer()
                Button(action: {
                    self.data.finishDrawing(patient : self.patient, drawingName: "circle" + trialnum.description + ".csv")
                    trialnum += 1
                    if trialnum >= trials {
                        self.rootIsActive.toggle()
                    } else {
                        self.drawings = [Drawing]()
                        self.data = DrawingData()
                    }
                }) {
                    if trialnum < trials - 1 {
                        Text("Next Trial").foregroundColor(.white)
                    } else {
                        Text("Finish Drawing").foregroundColor(.white)
                    }
                }
            }
            .padding()
            .background(Rectangle().foregroundColor(.black))
            .cornerRadius(5)
            Spacer()
        }.navigationBarHidden(true)
        .navigationTitle("Trial " + (trialnum + 1).description + "/" + trials.description)
    }
    
}

