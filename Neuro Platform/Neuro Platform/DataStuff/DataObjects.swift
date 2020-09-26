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
    var coordinates : [ CGPoint ]
    var timestamps : [ TimeInterval ]
    var velocities : [ Double ]
    var forces : [ CGFloat ]
    var azimii : [ CGFloat ]
    var started : Bool
//    Following variables used for calculating velocities
    var lastPoint : CGPoint
    var lastTime : TimeInterval
    
    init() {
        coordinates = [CGPoint]()
        timestamps = [TimeInterval]()
        velocities = [Double]()
        forces = [CGFloat]()
        azimii = [CGFloat]()
        lastPoint = CGPoint(x: -1, y: -1)
        lastTime = TimeInterval()
        started = false
    }
    
    func update(value : UITouch, view : UIView) {
        let location = value.location(in: view)
        let azimuth = value.azimuthAngle(in: view)
        let force = value.force
        
        coordinates.append(location)
        timestamps.append(value.timestamp)
        forces.append(force)
        azimii.append(azimuth)
        
        if !started {
            lastPoint = location
            lastTime = value.timestamp
            velocities.append(0)
            
            started = true
        } else {
            let timeint = value.timestamp - lastTime
            let distance = sqrt(pow(lastPoint.x - location.x, 2)
                + pow(lastPoint.y - location.y, 2))
            velocities.append(Double(distance) / timeint)
        }
    }
    
    /**
     Called when a drawing is finished. Saves contents of this object to system storage for later access and conversion to JSON.
     */
    func finishDrawing(patient : String, drawingName : String = "drawing.csv") {
        let url : URL = getDocumentsDirectory(foldername: patient, filename: drawingName)
        let str : String = CSVString()
        do {
            try str.write(to: url, atomically: true, encoding: .utf8)
            let input = try String(contentsOf: url)
            print(input)
        } catch {
            print("Failed to write to disk")
            print(error.localizedDescription)
        }
    }
    
    private func CSVString() -> String {
        var str : String = "Coordinates,Timestamp,Velocity,force,azimuth\n"
        for index in 0...coordinates.count - 1 {
            str = str + "\"" + coordinates[index].x.description + "," + coordinates[index].y.description + "\"," + timestamps[index].description + "," + velocities[index].description + "," + forces[index].description + "," + azimii[index].description + "\n"
        }

        return str
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
