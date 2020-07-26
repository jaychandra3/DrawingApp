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
