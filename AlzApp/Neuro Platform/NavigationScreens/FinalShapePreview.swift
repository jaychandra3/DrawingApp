//
//  FinalShapePreview.swift
//  Neuro Platform
//
//  Created by Jason Shang on 8/23/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

import SwiftUI

struct FinalShapePreview: View {
    var shape: String
    
    @State private var currentDrawing : Drawing = Drawing()
    @State private var drawings : [Drawing] = [Drawing]()
    @Binding var data: DrawingData
    @State private var scalar : CGFloat = UIScreen.screenWidth/1150
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Template: ").bold().font(.system(size:20)).padding(.top, 2)
            
            if shape == "circle" {
                Level1().stroke(lineWidth:3).padding(.top, -20)
            } else if shape == "infinity_symbol" {
                Infinity().stroke(lineWidth:3).padding(.top, -20)
            } else if shape == "prism" {
                Prism().stroke(lineWidth:3).padding(.top, -20)
            } else if shape == "arch_spiral" {
                ArchSpiral().stroke(lineWidth:3).padding(.top, -20)
            } else if shape == "circle_alz" {
                Level1().stroke(lineWidth:3).padding(.top, -20)
            } else if shape == "circle_triangle" {
                Level2().stroke(lineWidth:3).padding(.top, -20)
            } else if shape == "circle_triangle_rect" {
                Level3().stroke(lineWidth:3).padding(.top, -20)
            } else if shape == "circle_prism_triangle" {
                Level4().stroke(lineWidth:3).padding(.top, -20)
            } else if shape == "level5_undecided" {
                Level5().stroke(lineWidth:3).padding(.top, -20)
            } else if shape == "spirograph" {
                Spirograph().stroke(lineWidth:3).padding(.top, -20)
            } else {
                EmptyView()
            }
            
            Divider()
            Text("Your Drawing: ").bold().font(.system(size:20)).padding(.top, -55)
            if shape == "spirograph" {
                Text("(Draw downwards starting at red dot").font(.system(size: 12)).padding(.top, -47)
            }
            
            ZStack {
                DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data).opacity(0.1)
            }.padding(.top, -10)
        }.padding()
    }
}
