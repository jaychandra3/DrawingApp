//
//  CustomShapes.swift
//  Neuro Platform
//
//  Created by user175482 on 6/27/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import Foundation
import CoreGraphics
import SwiftUI

struct SpiroSquare: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rotations = 5
        let amount = .pi / CGFloat(rotations)
        let transform = CGAffineTransform(rotationAngle: amount)
        
        for _ in 0 ..< rotations {
            path = path.applying(transform)
            
            path.addRect(CGRect(x: -rect.width / 2, y: -rect.height / 2, width: rect.width, height: rect.height))
        }
        
        return path
    }
}

struct MultipleShapes: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
                                                    //Triangle coords
           path.move(to: CGPoint(x: 650, y: 450))       //1
        path.addLine(to: CGPoint(x: 550, y: 600))       //2
        path.addLine(to: CGPoint(x: 750, y: 600))       //3
        path.addLine(to: CGPoint(x: 650, y: 450))       //wrap(1)
        
                                                    //Rectangle coords
           path.move(to: CGPoint(x: 250, y: 550))       //1
        path.addLine(to: CGPoint(x: 250, y: 350))       //2
        path.addLine(to: CGPoint(x: 320, y: 260))       //3
        path.addLine(to: CGPoint(x: 720, y: 260))       //4
        path.addLine(to: CGPoint(x: 720, y: 460))       //5
        path.addLine(to: CGPoint(x: 650, y: 550))       //6
        path.addLine(to: CGPoint(x: 650, y: 350))       //7
        path.addLine(to: CGPoint(x: 720, y: 260))       //wrap(4)
        path.addLine(to: CGPoint(x: 650, y: 350))       //A(7)
        path.addLine(to: CGPoint(x: 250, y: 350))       //B(2)
        path.addLine(to: CGPoint(x: 250, y: 550))       //C(1)
        path.addLine(to: CGPoint(x: 650, y: 550))       //C(6)
        
                                                    //Circle specifications
        path.move(to: CGPoint(x: 280, y: 420))
        path.addArc(center: CGPoint(x: 280, y: 420), radius: 200,
                    startAngle: .degrees(0), endAngle: .degrees(0), clockwise: true)
        
        
        return path
    }
}


