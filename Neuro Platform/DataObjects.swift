//
//  DataObjects.swift
//  Neuro Platform
//
//  Created by user175482 on 7/1/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import Foundation
import CoreGraphics
import SwiftUI

class UserData {
    var coordinates : [CGPoint]
    var timestamps : [Date]
    var velocities : [Double]
    var lastPoint : CGPoint
    var lastTime : Date
    var started : Bool
    
    init() {
        coordinates = [CGPoint]()
        timestamps = [Date]()
        velocities = [Double]()
        lastPoint = CGPoint(x: -1, y: -1)
        lastTime = Date()
        started = false
    }
    
    func update(value : DragGesture.Value) {
        coordinates.append(value.location)
        timestamps.append(value.time)
        
        if !started {
            lastPoint = value.location
            lastTime = value.time
            velocities.append(0)
            started = true
        } else {
            let timeint = value.time.timeIntervalSince(lastTime).magnitude
            let distance = sqrt(pow(lastPoint.x - value.location.x, 2) + pow(lastPoint.y - value.location.y, 2))
            coordinates.append(value.location)
            timestamps.append(value.time)
            velocities.append(Double(distance) / timeint)
        }
    }
    
    func printInfo() {
        print(coordinates)
    }
    
    
}
