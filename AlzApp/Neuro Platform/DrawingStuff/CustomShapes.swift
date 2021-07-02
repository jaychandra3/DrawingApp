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

// height x width is 1366 x 1024 for 5th generation iPad
// divide by 1200 to accomdate for variations in aspect ratios

struct ArchSpiral: Shape {
    func path(in rect: CGRect) -> Path {
        let scalar : CGFloat = UIScreen.screenWidth/1200
        var path = Path()
        for theta in stride(from: 0, through: 6.0*CGFloat.pi, by: 0.01) {
            let x = scalar * (500 + cos(theta) * 14 * theta)
            let y = scalar * (250 + sin(theta) * 14 * theta)
            if x > UIScreen.screenWidth || y > UIScreen.screenHeight  || x < 0 || y < 0 {
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
        let scalar : CGFloat = UIScreen.screenWidth/1200
        var path = Path()
            path.move(to: CGPoint(x: scalar * 250, y: scalar * 350))       //1
         path.addLine(to: CGPoint(x: scalar * 250, y: scalar * 150))       //2
         path.addLine(to: CGPoint(x: scalar * 320, y: scalar * 60))       //3
         path.addLine(to: CGPoint(x: scalar * 720, y: scalar * 60))       //4
         path.addLine(to: CGPoint(x: scalar * 720, y: scalar * 260))       //5
         path.addLine(to: CGPoint(x: scalar * 650, y: scalar * 350))       //6
         path.addLine(to: CGPoint(x: scalar * 650, y: scalar * 150))       //7
         path.addLine(to: CGPoint(x: scalar * 720, y: scalar * 60))       //wrap(4)
         path.addLine(to: CGPoint(x: scalar * 650, y: scalar * 150))       //A(7)
         path.addLine(to: CGPoint(x: scalar * 250, y: scalar * 150))       //B(2)
         path.addLine(to: CGPoint(x: scalar * 250, y: scalar * 350))       //C(1)
         path.addLine(to: CGPoint(x: scalar * 650, y: scalar * 350))       //C(6)
        return path
    }
}

struct Infinity: Shape {
    func path(in rect: CGRect) -> Path {
        let scalar : CGFloat = UIScreen.screenWidth/1200
        var path = Path()
        for theta in stride(from: 0, through: 2*CGFloat.pi, by: 0.01) {
            let x = scalar * (500 + 2.2 * ((200 * cos(theta)) / (1 + (sin(theta) * sin(theta)))))
            let y = scalar * (250 + 2.2 * ((200 * sin(theta) * cos(theta)) / (1 + (sin(theta) * sin(theta)))))

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
        let scalar : CGFloat = UIScreen.screenWidth/1200
        var path = Path()
        for theta in stride(from: 0, through: 100*CGFloat.pi, by: 0.01) {
            let x = scalar * (500 + 5.5 * (25 * cos(theta) + 15 * cos(1/3 * theta)))
            let y = scalar * (250 + 5.5 * (25 * sin(theta) - 15 * sin(1/3 * theta)))
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
        let scalar : CGFloat = UIScreen.screenWidth/1200
        var path = Path()
        //Circle specifications
        path.addArc(center: CGPoint(x: scalar * 350, y: scalar * 247), radius: scalar * 200, startAngle: .degrees(0), endAngle: .degrees(359.99999), clockwise: false)
        return path
    }
}

struct Level2: Shape {
    func path(in rect: CGRect) -> Path {
        let scalar : CGFloat = UIScreen.screenWidth/1200
        var path = Path()
                //Circle specifications
        path.addArc(center: CGPoint(x: scalar * 350, y: scalar * 247), radius: scalar * 200,
        startAngle: .degrees(0), endAngle: .degrees(359.99999), clockwise: false)
                                                    //Triangle coords
                //Triangle coords
        path.move(to: CGPoint(x: scalar * 750, y: scalar * 250))       //1
        path.addLine(to: CGPoint(x: scalar * 650, y: scalar * 400))       //2
        path.addLine(to: CGPoint(x: scalar * 850, y: scalar * 400))       //3
        path.addLine(to: CGPoint(x: scalar * 750, y: scalar * 250))       //wrap(1)
        return path
    }
}

struct Level3: Shape {
    func path(in rect: CGRect) -> Path {
        let scalar : CGFloat = UIScreen.screenWidth/1200
        var path = Path()
                                                    //Circle specifications
        path.addArc(center: CGPoint(x: scalar * 350, y: scalar * 247), radius: scalar * 200,
        startAngle: .degrees(0), endAngle: .degrees(359.99999), clockwise: false)
                                                    //Triangle coords
                //Triangle coords
        path.move(to: CGPoint(x: scalar * 750, y: scalar * 250))       //1
        path.addLine(to: CGPoint(x: scalar * 650, y: scalar * 400))       //2
        path.addLine(to: CGPoint(x: scalar * 850, y: scalar * 400))       //3
        path.addLine(to: CGPoint(x: scalar * 750, y: scalar * 250))       //wrap(1)
                                                    //Rectangle coords
        path.addLine(to: CGPoint(x: scalar * 750, y: scalar * 150))       //A(7)
        path.addLine(to: CGPoint(x: scalar * 350, y: scalar * 150))       //B(2)
        path.addLine(to: CGPoint(x: scalar * 350, y: scalar * 350))       //C(1)
        path.addLine(to: CGPoint(x: scalar * 750, y: scalar * 350))       //C(6)
        path.addLine(to: CGPoint(x: scalar * 750, y: scalar * 250))       //wrap(1)
        return path
    }
}
struct Level4: Shape {
    func path(in rect: CGRect) -> Path {
        let scalar : CGFloat = UIScreen.screenWidth/1200
        var path = Path()
                                                    //Circle specifications
            path.addArc(center: CGPoint(x: scalar * 350, y: scalar * 247), radius: scalar * 200,
                        startAngle: .degrees(0), endAngle: .degrees(359.99999), clockwise: false)
                                                    //Triangle coords
            path.move(to: CGPoint(x: scalar * 750, y: scalar * 250))       //1
        path.addLine(to: CGPoint(x: scalar * 650, y: scalar * 400))       //2
        path.addLine(to: CGPoint(x: scalar * 850, y: scalar * 400))       //3
        path.addLine(to: CGPoint(x: scalar * 750, y: scalar * 250))       //wrap(1)
                                                    //Prism coords
            path.move(to: CGPoint(x: scalar * 350, y: scalar * 350))       //1
        path.addLine(to: CGPoint(x: scalar * 350, y: scalar * 150))       //2
        path.addLine(to: CGPoint(x: scalar * 420, y: scalar * 060))       //3
        path.addLine(to: CGPoint(x: scalar * 820, y: scalar * 060))       //4
        path.addLine(to: CGPoint(x: scalar * 820, y: scalar * 260))       //5
        path.addLine(to: CGPoint(x: scalar * 750, y: scalar * 350))       //6
        path.addLine(to: CGPoint(x: scalar * 750, y: scalar * 150))       //7
        path.addLine(to: CGPoint(x: scalar * 820, y: scalar * 060))       //wrap(4)
        path.addLine(to: CGPoint(x: scalar * 750, y: scalar * 150))       //A(7)
        path.addLine(to: CGPoint(x: scalar * 350, y: scalar * 150))       //B(2)
        path.addLine(to: CGPoint(x: scalar * 350, y: scalar * 350))       //C(1)
        path.addLine(to: CGPoint(x: scalar * 750, y: scalar * 350))       //C(6)
        return path
    }
}

struct Level5: Shape {
    func path(in rect: CGRect) -> Path {
        let scalar : CGFloat = UIScreen.screenWidth/1200
        var path = Path()
                                                //Circle specifications
        path.addArc(center: CGPoint(x: scalar * 350, y: scalar * 247), radius: scalar * 200,
                    startAngle: .degrees(0), endAngle: .degrees(359.99999), clockwise: false)
                                                //Triangle coords
       path.move(to: CGPoint(x: scalar * 750, y: scalar * 250))       //1
    path.addLine(to: CGPoint(x: scalar * 650, y: scalar * 400))       //2
    path.addLine(to: CGPoint(x: scalar * 850, y: scalar * 400))       //3
    path.addLine(to: CGPoint(x: scalar * 750, y: scalar * 250))       //wrap(1)
                                                //Prism coords
        path.move(to: CGPoint(x: scalar * 350, y: scalar * 350))       //1
    path.addLine(to: CGPoint(x: scalar * 350, y: scalar * 150))       //2
    path.addLine(to: CGPoint(x: scalar * 420, y: scalar * 060))       //3
    path.addLine(to: CGPoint(x: scalar * 820, y: scalar * 060))       //4
    path.addLine(to: CGPoint(x: scalar * 820, y: scalar * 260))       //5
    path.addLine(to: CGPoint(x: scalar * 750, y: scalar * 350))       //6
    path.addLine(to: CGPoint(x: scalar * 750, y: scalar * 150))       //7
    path.addLine(to: CGPoint(x: scalar * 820, y: scalar * 060))       //wrap(4)
    path.addLine(to: CGPoint(x: scalar * 750, y: scalar * 150))       //A(7)
    path.addLine(to: CGPoint(x: scalar * 350, y: scalar * 150))       //B(2)
    path.addLine(to: CGPoint(x: scalar * 350, y: scalar * 350))       //C(1)
    path.addLine(to: CGPoint(x: scalar * 750, y: scalar * 350))       //C(6)
                                                //Blob coords
       path.move(to: CGPoint(x: scalar * 500, y: scalar * 230))       //1
    path.addLine(to: CGPoint(x: scalar * 200, y: scalar * 130))       //2
    path.addLine(to: CGPoint(x: scalar * 280, y: scalar * 350))       //3
    path.addLine(to: CGPoint(x: scalar * 320, y: scalar * 300))       //4
    path.addLine(to: CGPoint(x: scalar * 380, y: scalar * 400))       //5
    path.addLine(to: CGPoint(x: scalar * 500, y: scalar * 230))        //wrap
        return path
    }
}
