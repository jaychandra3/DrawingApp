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

class DrawingData {
    var coordinates : [CGPoint]
    var timestamps : [TimeInterval]
    var velocities : [Double]
    var started : Bool
//    Following variables used for calculating velocities
    var lastPoint : CGPoint
    var lastTime : TimeInterval
    
    init() {
        coordinates = [CGPoint]()
        timestamps = [TimeInterval]()
        velocities = [Double]()
        lastPoint = CGPoint(x: -1, y: -1)
        lastTime = TimeInterval()
        started = false
    }
    
    func update(value : UITouch, location : CGPoint) {
        coordinates.append(location)
        
        if !started {
            lastPoint = location
            lastTime = value.timestamp
            velocities.append(0)
            started = true
        } else {
            let timeint = value.timestamp - lastTime
            let distance = sqrt(pow(lastPoint.x - location.x, 2)
                + pow(lastPoint.y - location.y, 2))
            coordinates.append(location)
            timestamps.append(value.timestamp)
            print(Double(distance) / timeint)
            velocities.append(Double(distance) / timeint)
      
        }
    }
    
    func finishDrawing() {
//        TODO
    }
    
    func printInfo() {
//        TODO
    }
    
    func convertToJSON() {
//        TODO
    }
    
    
    
}

class UserData {
    
    init() {
        
    }
}
