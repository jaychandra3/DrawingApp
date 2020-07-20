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
    let color : Color = .black
    let lineWidth : CGFloat = 3.0
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
            
        }
        .frame(maxHeight: .infinity)
    }
    
        private func continueDrawing(point : CGPoint) {
    //        user.update(value: value)
            let currentPoint = point
    //        if currentPoint.y >= 0
    //            && currentPoint.y < geometry.size.height {
                currentDrawing.points.append(currentPoint)
    //        }
        }
        
        private func finishDrawing(point : CGPoint) {
    //        self.user.update(value: value)
            drawings.append(currentDrawing)
            currentDrawing = Drawing()
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
