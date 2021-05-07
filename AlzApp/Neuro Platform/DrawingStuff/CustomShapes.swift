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

// shapes with explicit names are for Parkinson's 
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

struct ArchSpiral: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for theta in stride(from: 0, through: 20*CGFloat.pi, by: 0.01) {
            let x = 400 + cos(theta) * 16.8 * theta
            let y = 385 + sin(theta) * 16.8 * theta
            if x > 800 || y > 800  || x < 0 || y < 0 {
                break
            }
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            }
            else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
        }
        return path
    }
}

struct Prism: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
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
        return path
    }
}

struct Infinity: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for theta in stride(from: 0, through: 2*CGFloat.pi, by: 0.01) {
            let x = 550 + (200 * cos(theta)) / (1 + (sin(theta) * sin(theta)))
            let y = 500 + (200 * sin(theta) * cos(theta)) / (1 + (sin(theta) * sin(theta)))
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            }
            else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
        }
        return path
    }
}

struct Spirograph: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for theta in stride(from: 0, through: 100*CGFloat.pi, by: 0.01) {
            let x = 550 + 6 * (25 * cos(theta) + 15 * cos(1/39 * theta))
            let y = 550 + 6 * (25 * sin(theta) - 15 * sin(1/39 * theta))
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            }
            else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
        }
        return path
    }
}

// Levels are for Alzheimer's
struct Level1: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
                                                    //Circle specifications
            path.addArc(center: CGPoint(x: 250, y: 447), radius: 200,
                        startAngle: .degrees(0), endAngle: .degrees(359.99999), clockwise: false)
        
        return path
    }
}

struct Level2: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addArc(center: CGPoint(x: 250, y: 447), radius: 200,
                    startAngle: .degrees(0), endAngle: .degrees(359.99999), clockwise: false)
        
                                                    //Triangle coords
           path.move(to: CGPoint(x: 650, y: 450))       //1
        path.addLine(to: CGPoint(x: 550, y: 600))       //2
        path.addLine(to: CGPoint(x: 750, y: 600))       //3
        path.addLine(to: CGPoint(x: 650, y: 450))       //wrap(1)
        
        return path
    }
}

struct Level3: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
                                                    //Circle specifications
            path.addArc(center: CGPoint(x: 250, y: 447), radius: 200,
                        startAngle: .degrees(0), endAngle: .degrees(359.99999), clockwise: false)
        
                                                    //Triangle coords
           path.move(to: CGPoint(x: 650, y: 450))       //1
        path.addLine(to: CGPoint(x: 550, y: 600))       //2
        path.addLine(to: CGPoint(x: 750, y: 600))       //3
        path.addLine(to: CGPoint(x: 650, y: 450))       //wrap(1)
        
                                                    //Rectangle coords
        path.addLine(to: CGPoint(x: 650, y: 350))       //A(7)
        path.addLine(to: CGPoint(x: 250, y: 350))       //B(2)
        path.addLine(to: CGPoint(x: 250, y: 550))       //C(1)
        path.addLine(to: CGPoint(x: 650, y: 550))       //C(6)
        
        return path
    }
}

struct Level4: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
                                                    //Circle specifications
            path.addArc(center: CGPoint(x: 250, y: 447), radius: 200,
                        startAngle: .degrees(0), endAngle: .degrees(359.99999), clockwise: false)
        
                                                    //Triangle coords
           path.move(to: CGPoint(x: 650, y: 450))       //1
        path.addLine(to: CGPoint(x: 550, y: 600))       //2
        path.addLine(to: CGPoint(x: 750, y: 600))       //3
        path.addLine(to: CGPoint(x: 650, y: 450))       //wrap(1)
        
                                                    //Prism coords
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
        
        
        return path
    }
}

struct Level5: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
                                                    //Circle specifications
            path.addArc(center: CGPoint(x: 250, y: 447), radius: 200,
                        startAngle: .degrees(0), endAngle: .degrees(359.99999), clockwise: false)
        
                                                    //Triangle coords
           path.move(to: CGPoint(x: 650, y: 450))       //1
        path.addLine(to: CGPoint(x: 550, y: 600))       //2
        path.addLine(to: CGPoint(x: 750, y: 600))       //3
        path.addLine(to: CGPoint(x: 650, y: 450))       //wrap(1)
        
                                                    //Prism coords
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

        return path
    }
}






