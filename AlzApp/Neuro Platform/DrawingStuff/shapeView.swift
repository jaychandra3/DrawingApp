//
//  shapeView.swift
//  Neuro Platform
//
//  Created by Jason Shang on 5/5/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

import SwiftUI

struct shapeView: View {
    var shape: String
    
    @State private var currentDrawing : Drawing = Drawing()
    @State private var drawings : [Drawing] = [Drawing]()
    @Binding var data: DrawingData
    @State private var scalar : CGFloat = UIScreen.screenWidth/1150
    
    var body: some View {
        if shape == "circle" {
            VStack (alignment: .leading) {
                Text("Template: ").bold().font(.system(size:20)).padding(.top, 2)
                Level1().stroke(lineWidth:3)
                Divider()
                Text("Your Drawing: ").bold().font(.system(size:20)).padding(.top, -50)
                ZStack {
                    DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                    Level1().stroke(style: StrokeStyle(lineWidth:3, dash:[6])).opacity(0.5)
                    Circle().fill(Color.red.opacity(0.75)).frame(width: scalar * 15, height: scalar * 15).position(x: scalar * 350, y: scalar * (247 - 200))
                    TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data).opacity(0.1)
                }.padding(.top, -10)
            }.padding()
        } else if shape == "infinity_symbol" {
            VStack (alignment: .leading) {
                Text("Template: ").bold().font(.system(size:20)).padding(.top, 2)
                Infinity().stroke(lineWidth:3)
                Divider()
                Text("Your Drawing: ").bold().font(.system(size:20)).padding(.top, -50)
                ZStack {
                    DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                    Infinity().stroke(style: StrokeStyle(lineWidth:3, dash:[6])).opacity(0.5)
                    Circle().fill(Color.red.opacity(0.75)).frame(width: scalar * 15, height: scalar * 15).position(x: scalar * 500, y: scalar * 250)
                    TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data).opacity(0.1)
                }.padding(.top, -10)
            }.padding()
        } else if shape == "prism" {
            VStack (alignment: .leading) {
                Text("Template: ").bold().font(.system(size:20)).padding(.top, 2)
                Prism().stroke(lineWidth:3)
                Divider()
                Text("Your Drawing: ").bold().font(.system(size:20)).padding(.top, -50)
                ZStack {
                    DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                    Prism().stroke(style: StrokeStyle(lineWidth:3, dash:[6])).opacity(0.5)
                    Circle().fill(Color.red.opacity(0.75)).frame(width: scalar * 15, height: scalar * 15).position(x: scalar * 350, y: scalar * 150)
                    TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data).opacity(0.1)
                }.padding(.top, -10)
            }.padding()
        } else if shape == "arch_spiral" {
            VStack (alignment: .leading) {
                Text("Template: ").bold().font(.system(size:20)).padding(.top, 2)
                ArchSpiral().stroke(lineWidth:3)
                Divider()
                Text("Your Drawing: ").bold().font(.system(size:20)).padding(.top, -50)
                ZStack {
                    DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                    ArchSpiral().stroke(style: StrokeStyle(lineWidth:3, dash:[6])).opacity(0.5)
                    Circle().fill(Color.red.opacity(0.75)).frame(width: scalar * 15, height: scalar * 15).position(x: scalar * 500, y: scalar * 250)
                    TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data).opacity(0.1)
                }.padding(.top, -10)
            }.padding()
        } else if shape == "circle_alz" {
            VStack (alignment: .leading) {
                Text("Template: ").bold().font(.system(size:20)).padding(.top, 2)
                Level1().stroke(lineWidth:3)
                Divider()
                Text("Your Drawing: ").bold().font(.system(size:20)).padding(.top, -50)
                ZStack {
                    DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                    Level1().stroke(style: StrokeStyle(lineWidth:3, dash:[6])).opacity(0.5)
                    Circle().fill(Color.red.opacity(0.75)).frame(width: scalar * 15, height: scalar * 15).position(x: scalar * 350, y: scalar * (247 - 200))
                    TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data).opacity(0.1)
                }.padding(.top, -10)
            }.padding()
        } else if shape == "circle_triangle" {
            VStack (alignment: .leading) {
                Text("Template: ").bold().font(.system(size:20)).padding(.top, 2)
                Level2().stroke(lineWidth:3)
                Divider()
                Text("Your Drawing: ").bold().font(.system(size:20)).padding(.top, -50)
                ZStack {
                    DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                    Level2().stroke(style: StrokeStyle(lineWidth:3, dash:[6])).opacity(0.5)
                    TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data).opacity(0.1)
                }.padding(.top, -10)
            }.padding()
        } else if shape == "circle_triangle_rect" {
            VStack (alignment: .leading) {
                Text("Template: ").bold().font(.system(size:20)).padding(.top, 2)
                Level3().stroke(lineWidth:3)
                Divider()
                Text("Your Drawing: ").bold().font(.system(size:20)).padding(.top, -50)
                ZStack {
                    DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                    Level3().stroke(style: StrokeStyle(lineWidth:3, dash:[6])).opacity(0.5)
                    TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data).opacity(0.1)
                }.padding(.top, -10)
            }.padding()
        } else if shape == "circle_prism_triangle" {
            VStack (alignment: .leading) {
                Text("Template: ").bold().font(.system(size:20)).padding(.top, 2)
                Level4().stroke(lineWidth:3)
                Divider()
                Text("Your Drawing: ").bold().font(.system(size:20)).padding(.top, -50)
                ZStack {
                    DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                    Level4().stroke(style: StrokeStyle(lineWidth:3, dash:[6])).opacity(0.5)
                    TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data).opacity(0.1)
                }.padding(.top, -10)
            }.padding()
        } else if shape == "level5_undecided" {
            VStack (alignment: .leading) {
                Text("Template: ").bold().font(.system(size:20)).padding(.top, 2)
                Level5().stroke(lineWidth:3)
                Divider()
                Text("Your Drawing: ").bold().font(.system(size:20)).padding(.top, -50)
                ZStack {
                    DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                    Level5().stroke(style: StrokeStyle(lineWidth:3, dash:[6])).opacity(0.5)
                    TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data).opacity(0.1)
                }.padding(.top, -10)
            }.padding()
        }
        else  if shape == "spirograph" {
            VStack (alignment: .leading) {
                Text("Template: ").bold().font(.system(size:20)).padding(.top, 2)
                Spirograph().stroke(lineWidth:3)
                Divider()
                HStack {
                    Text("Your Drawing: ").bold().font(.system(size:20)).padding(.top, -50)
                    Text("(Draw downwards starting at red dot)").font(.system(size:12)).padding(.top, -43)
                }
                ZStack {
                    DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                    Spirograph().stroke(style: StrokeStyle(lineWidth:3, dash:[6])).opacity(0.5)
                    Circle().fill(Color.red.opacity(0.75)).frame(width: scalar * 15, height: scalar * 15).position(x: scalar*720, y: scalar*250)
                    TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data).opacity(0.1)
                }.padding(.top, -10)
            }.padding()
        } else {
            Spacer()
            EmptyView()
        }
    }
}

/*
struct shapeView_Previews: PreviewProvider {
    static var previews: some View {
        shapeView(shape: "circle", data: $data)
    }
}
*/
