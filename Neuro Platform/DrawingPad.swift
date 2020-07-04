//
//  DrawingPad.swift
//  Neuro Platform
//
//  Created by user175482 on 6/18/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI

struct DrawingPad: View {
    @Binding var currentDrawing : Drawing
    @Binding var drawings : [Drawing]
    @Binding var color : Color
    @Binding var lineWidth : CGFloat
    let user : DrawingData = DrawingData()
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for drawing in self.drawings {
                    self.add(drawing: drawing, toPath: &path)
                }
                self.add(drawing: self.currentDrawing, toPath: &path)
            }
            .stroke(self.color, lineWidth: self.lineWidth)
            .background(Color(white:0.95))
            .gesture(
                DragGesture(minimumDistance: 0.1)
                .onChanged({(value) in
                    print(value)
                    self.user.update(value: value)
                    let currentPoint = value.location
                    if currentPoint.y >= 0
                        && currentPoint.y < geometry.size.height {
                        self.currentDrawing.points.append(currentPoint)
                    }
                })
                .onEnded({(value) in
                    self.user.update(value: value)
                    self.drawings.append(self.currentDrawing)
                    self.currentDrawing = Drawing()
                })
            )
        }
        .frame(maxHeight: .infinity)
    }
    
    private func add(drawing : Drawing, toPath path : inout Path) {
        let points = drawing.points
        if points.count > 1 {
            for i in 0..<points.count - 1 {
                let current = points[i]
                let next = points[i+1]
                path.move(to: current)
                path.addLine(to: next)
            }
        }
    }
}
