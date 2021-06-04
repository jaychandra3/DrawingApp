//
//  ErrorCalc.swift
//  Neuro Platform
//
//  Created by md on 5/23/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

import Foundation
import SwiftUI

class ErrorCalc {
    var isAlz : Bool
    var level : Int
    var data : DrawingData
    
    init(isAlz : Bool, level: Int, data: DrawingData) {
        self.isAlz = isAlz
        self.level = level
        self.data = data
    }
    
    func calcError() -> CGFloat{
        var min_error : CGFloat = 0
        var total_error : CGFloat = 0
        var avg_error : CGFloat = 0
        var count : CGFloat = 0
        var error_arr : [CGFloat] = [CGFloat]()
        let spiral_center : CGPoint = CGPoint(x: 500, y: 250)
        let infinity_center : CGPoint = CGPoint(x: 500, y: 250)
        let spirograph_center: CGPoint = CGPoint(x: 500, y: 250)
        
        for point in data.coordinates{
            print("X: " + point.x.description + " Y: " + point.y.description)
            
            // Distance to Spiral
            if (!isAlz && level == 4) {
            // center everything at (0,0)
            let norm_point : CGPoint = CGPoint(x: point.x-spiral_center.x, y: point.y-spiral_center.y)
                if(norm_point.x*norm_point.x+norm_point.y+norm_point.y < 2000) {
                    error_arr.append(sqrt(norm_point.x*norm_point.x + norm_point.y*norm_point.y))
                }
                // distance to theta-based projection onto spiral
                let theta : CGFloat = calcTheta(p: norm_point)
                let nearest_ring : CGFloat = CGFloat(Int(sqrt(norm_point.x*norm_point.x + norm_point.y*norm_point.y) / (14*2*CGFloat.pi)))
                let theta1 : CGFloat = theta + 2*CGFloat.pi*nearest_ring
                let theta2 : CGFloat = theta1 + 2*CGFloat.pi
                var projected_radius : CGFloat = 14*theta1
                error_arr.append(abs(sqrt(norm_point.x*norm_point.x + norm_point.y*norm_point.y) - projected_radius))
                projected_radius = 14*theta2
                error_arr.append(abs(sqrt(norm_point.x*norm_point.x + norm_point.y*norm_point.y) - projected_radius))
                if (nearest_ring >= 1) {
                    let theta3 : CGFloat = theta1 - 2*CGFloat.pi
                    projected_radius = 14*theta3
                    error_arr.append(abs(sqrt(norm_point.x*norm_point.x + norm_point.y*norm_point.y) - projected_radius))
                }
            }
            
            // Distance to Infinity Symbol
            if (!isAlz && level == 2) {
                let norm_point : CGPoint = CGPoint(x: point.x-infinity_center.x, y: infinity_center.y-point.y)
                
                 // one error is distance to theta-based projection onto infinity
                let theta : CGFloat = calcTheta(p: norm_point)
                let projected_radius : CGFloat = sqrt(2.2*200*2.2*200*cos(2*theta))
                
                // if point is within a circle with radius 370
                // another error is distance to approximating parabola y = -(1/500)x(x-500)
                if (norm_point.x*norm_point.x + norm_point.y*norm_point.y <= 136900 || norm_point.x*norm_point.x + norm_point.y*norm_point.y - projected_radius < 0) {
                    if (norm_point.x >= 0 && norm_point.y >= 0) {
                        error_arr.append(distanceToParabola(p: norm_point, a: -0.002, b: 1.1, c: 0))
                    }
                    else if (norm_point.x < 0 && norm_point.y >= 0) {
                        error_arr.append(distanceToParabola(p: norm_point, a: -0.002, b: -1.1, c: 0))
                    }
                    else if (norm_point.x < 0 && norm_point.y < 0) {
                        error_arr.append(distanceToParabola(p: norm_point, a: 0.002, b: 1.1, c: 0))
                    }
                    else {
                        error_arr.append(distanceToParabola(p: norm_point, a: 0.002, b: -1.1, c: 0))
                    }
                }
      
                if (norm_point.x*norm_point.x + norm_point.y*norm_point.y - projected_radius >= 0) {
                    error_arr.append(abs(sqrt(norm_point.x*norm_point.x + norm_point.y*norm_point.y) - projected_radius))
                }
            
            }
            
            // Distance to Spirograph
            if (!isAlz && level == 5) {
                let norm_point : CGPoint = CGPoint(x: point.x-spirograph_center.x, y: spirograph_center.y-point.y)
                print("X': " + norm_point.x.description + " Y': " + norm_point.y.description)
                // based on the quadrant, distance to various approximating circles and ellipses are calculated
                if (norm_point.x >= 0 && norm_point.y >= 0) {
                    error_arr.append(distanceToCircle(p: norm_point, center: CGPoint(x: -100, y: 100), radius: 197))
                    error_arr.append(distanceToCircle(p: norm_point, center: CGPoint(x: 100, y: -100), radius: 197))
                    error_arr.append(distanceToCircle(p: norm_point, center: CGPoint(x: -100, y: -100), radius: 197))
                    error_arr.append(distanceToEllipse(p: norm_point, center: CGPoint(x: 100, y: 0), x_radius: 120, y_radius: 100))
                    error_arr.append(distanceToEllipse(p: norm_point, center: CGPoint(x: 0, y: 100), x_radius: 100, y_radius: 120))
                }
                else if (norm_point.x < 0 && norm_point.y >= 0) {
                    error_arr.append(distanceToCircle(p: norm_point, center: CGPoint(x: 100, y: 100), radius: 197))
                    error_arr.append(distanceToCircle(p: norm_point, center: CGPoint(x: 100, y: -100), radius: 197))
                    error_arr.append(distanceToCircle(p: norm_point, center: CGPoint(x: -100, y: -100), radius: 197))
                    error_arr.append(distanceToEllipse(p: norm_point, center: CGPoint(x: 0, y: 100), x_radius: 100, y_radius: 120))
                    error_arr.append(distanceToEllipse(p: norm_point, center: CGPoint(x: -100, y: 0), x_radius: 120, y_radius: 100))
                }
                else if (norm_point.x < 0 && norm_point.y < 0) {
                    error_arr.append(distanceToCircle(p: norm_point, center: CGPoint(x: 100, y: 100), radius: 197))
                    error_arr.append(distanceToCircle(p: norm_point, center: CGPoint(x: -100, y: 100), radius: 197))
                    error_arr.append(distanceToCircle(p: norm_point, center: CGPoint(x: 100, y: -100), radius: 197))
                    error_arr.append(distanceToEllipse(p: norm_point, center: CGPoint(x: -100, y: 0), x_radius: 120, y_radius: 100))
                    error_arr.append(distanceToEllipse(p: norm_point, center: CGPoint(x: 0, y: -100), x_radius: 100, y_radius: 120))
                }
                else {
                    error_arr.append(distanceToCircle(p: norm_point, center: CGPoint(x: 100, y: 100), radius: 197))
                    error_arr.append(distanceToCircle(p: norm_point, center: CGPoint(x: -100, y: 100), radius: 197))
                    error_arr.append(distanceToCircle(p: norm_point, center: CGPoint(x: -100, y: -100), radius: 197))
                    error_arr.append(distanceToEllipse(p: norm_point, center: CGPoint(x: 100, y: 0), x_radius: 120, y_radius: 100))
                    error_arr.append(distanceToEllipse(p: norm_point, center: CGPoint(x: 0, y: -100), x_radius: 100, y_radius: 120))
                }
            }
            
            // Distance to Wave (need to figure out level)
            if (level == -1) {
                print("wave")
                error_arr.append(abs(250 + 0.2 * point.x * sin(0.05 * point.x) - point.y))
            }
            
            // Distance to Park Circle
            if (!isAlz && level == 1) {
                error_arr.append(distanceToCircle(p: point, center: CGPoint(x: 500,y: 247), radius: 200))
            }
            
            // Distance to Park Prism
            if (!isAlz && level == 3) {
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 250, y: 350), and: CGPoint(x: 250, y: 150)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 250, y: 150), and: CGPoint(x: 320, y: 60)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 320, y: 60), and: CGPoint(x: 720, y: 60)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 720, y: 60), and: CGPoint(x: 720, y: 260)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 720, y: 260), and: CGPoint(x: 650, y: 350)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 650, y: 350), and: CGPoint(x: 650, y: 150)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 650, y: 150), and: CGPoint(x: 720, y: 60)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 720, y: 60), and: CGPoint(x: 650, y: 150)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 650, y: 150), and: CGPoint(x: 250, y: 150)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 250, y: 150), and: CGPoint(x: 250, y: 350)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 250, y: 350), and: CGPoint(x: 650, y: 350)))
            }
            
            // Distance to Alz Circle
            if (isAlz) {
                error_arr.append(distanceToCircle(p: point, center: CGPoint(x: 350,y: 247), radius: 200))
            }
         
            // Distance to Triangle
            if (isAlz && level >= 2 && level <= 5) {
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 750, y: 250), and: CGPoint(x: 650, y: 400)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 650, y: 400), and: CGPoint(x: 850, y: 400)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 850, y: 400), and: CGPoint(x: 750, y: 250)))
            }
            
            // Distance to Rectangle
            if (isAlz && level == 3) {
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 750, y: 150), and: CGPoint(x: 350, y: 150)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 350, y: 150), and: CGPoint(x: 350, y: 350)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 350, y: 350), and: CGPoint(x: 750, y: 350)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 750, y: 350), and: CGPoint(x: 750, y: 150)))
            }

            // Distance to Alz Prism
            if (isAlz && level >= 4) {
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 350, y: 350), and: CGPoint(x: 350, y: 150)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 350, y: 150), and: CGPoint(x: 420, y: 60)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 420, y: 60), and: CGPoint(x: 820, y: 60)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 820, y: 60), and: CGPoint(x: 820, y: 260)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 820, y: 260), and: CGPoint(x: 750, y: 350)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 750, y: 350), and: CGPoint(x: 750, y: 150)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 750, y: 150), and: CGPoint(x: 820, y: 60)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 820, y: 60), and: CGPoint(x: 750, y: 150)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 750, y: 150), and: CGPoint(x: 350, y: 150)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 350, y: 150), and: CGPoint(x: 350, y: 350)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 350, y: 350), and: CGPoint(x: 750, y: 350)))
            }
            
            // Distance to Blob
            if (isAlz && level == 5) {
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 500, y: 230), and: CGPoint(x: 200, y: 130)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 200, y: 130), and: CGPoint(x: 280, y: 350)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 280, y: 350), and: CGPoint(x: 320, y: 300)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 320, y: 300), and: CGPoint(x: 380, y: 400)))
                error_arr.append(distanceFromPoint(p: point, toLineSegment: CGPoint(x: 380, y: 400), and: CGPoint(x: 500, y: 230)))
            }
            
            // Calculate min distance to overall figure
            min_error = error_arr.min() ?? -1
            print("Error: " + min_error.description)
            total_error += min_error
            error_arr.removeAll()
            count+=1
        }
        avg_error = total_error/count
        print("Avg Error: " + avg_error.description)
        print("--------------------------------------------------")
        return avg_error
    }

    // ensures that the subject can't "cheat" by not tracing the whole figure
    // each "zone" is a key point on the figure that the tracing must pass by
    func drawingComplete() -> Bool {
        var zones : [CGPoint] = []
        var radius : CGFloat = 35 // have different radii for diff figures
        // Check Spiral
        if (!isAlz && level == 4) {
            radius = 20
            zones.append(CGPoint(x: 500, y: 250))
            zones.append(CGPoint(x: 500, y: 184.027))
            zones.append(CGPoint(x: 500, y: 359.956))
            zones.append(CGPoint(x: 500, y: 96.062))
            zones.append(CGPoint(x: 500, y: 447.920))
            zones.append(CGPoint(x: 456.018, y: 250))
            zones.append(CGPoint(x: 587.966, y: 250))
            zones.append(CGPoint(x: 368.053, y: 250))
            zones.append(CGPoint(x: 675.929, y: 250))
            zones.append(CGPoint(x: 368.053, y: 250))
            zones.append(CGPoint(x: 280.089, y: 250))
            zones.append(CGPoint(x: 763.894, y: 250))
        }
        
        // Check Infinity Symbol
        if (!isAlz && level == 2) {
            zones.append(CGPoint(x: 500, y: 250))
            zones.append(CGPoint(x: 940, y: 250))
            zones.append(CGPoint(x: 60, y: 250))
            zones.append(CGPoint(x: 769.627, y: 405.563))
            zones.append(CGPoint(x: 230.373, y: 405.563))
            zones.append(CGPoint(x: 769.627, y: 94.437))
            zones.append(CGPoint(x: 230.373, y: 94.437))
        }
        
        // Check Spirograph
        if (!isAlz && level == 5) {
            zones.append(CGPoint(x: 720, y: 250))
            zones.append(CGPoint(x: 500, y: 470))
            zones.append(CGPoint(x: 280, y: 250))
            zones.append(CGPoint(x: 500, y: 30))
            zones.append(CGPoint(x: 598.385, y: 348.385))
            zones.append(CGPoint(x: 598.385, y: 151.615))
            zones.append(CGPoint(x: 401.615, y: 348.385))
            zones.append(CGPoint(x: 401.615, y: 151.615))
            zones.append(CGPoint(x: 569.570, y: 250))
            zones.append(CGPoint(x: 500, y: 319.570))
            zones.append(CGPoint(x: 430.43, y: 250))
            zones.append(CGPoint(x: 500, y: 180.43))
        }
        
        // Check Wave (need to figure out level)
        if (level == -1) {
            radius = 20
            zones.append(CGPoint(x: 0, y: 250))
            zones.append(CGPoint(x: 40.575, y: 257.279))
            zones.append(CGPoint(x: 98.264, y: 230.742))
            zones.append(CGPoint(x: 159.573, y: 281.667))
            zones.append(CGPoint(x: 221.711, y: 205.837))
            zones.append(CGPoint(x: 284.149, y: 306.689))
            zones.append(CGPoint(x: 346.728, y: 180.77))
            zones.append(CGPoint(x: 409.383, y: 331.779))
            zones.append(CGPoint(x: 472.086, y: 155.667))
            zones.append(CGPoint(x: 534.818, y: 356.889))
            zones.append(CGPoint(x: 597.572, y: 130.553))
            zones.append(CGPoint(x: 660.340, y: 382.007))
            zones.append(CGPoint(x: 723.119, y: 105.431))
            zones.append(CGPoint(x: 785.907, y: 407.131))
            zones.append(CGPoint(x: 848.701, y: 80.307))
            zones.append(CGPoint(x: 911.501, y: 432.256))
            zones.append(CGPoint(x: 974.304, y: 55.18))
        }
        
        // Check Park Circle
        if (level == 1) {
            zones.append(CGPoint(x: 700, y: 247))
            zones.append(CGPoint(x: 300, y: 247))
            zones.append(CGPoint(x: 500, y: 447))
            zones.append(CGPoint(x: 500, y: 47))
            zones.append(CGPoint(x: 641.421, y: 388.421))
            zones.append(CGPoint(x: 358.579, y: 388.421))
            zones.append(CGPoint(x: 641.421, y: 105.579))
            zones.append(CGPoint(x: 358.579, y: 105.579))
        }
        
        // Check Park Prism
        if (!isAlz && level == 3) {
            zones.append(CGPoint(x: 250, y: 350))
            zones.append(CGPoint(x: 250, y: 150))
            zones.append(CGPoint(x: 320, y: 60))
            zones.append(CGPoint(x: 720, y: 60))
            zones.append(CGPoint(x: 720, y: 260))
            zones.append(CGPoint(x: 650, y: 350))
            zones.append(CGPoint(x: 650, y: 150))
            zones.append(CGPoint(x: 720, y: 60))
            zones.append(CGPoint(x: 650, y: 150))
            zones.append(CGPoint(x: 250, y: 150))
            zones.append(CGPoint(x: 250, y: 350))
            zones.append(CGPoint(x: 650, y: 350))
        }
        
        // Check Alz Circle
        if (isAlz) {
            zones.append(CGPoint(x: 550, y: 247))
            zones.append(CGPoint(x: 150, y: 247))
            zones.append(CGPoint(x: 350, y: 447))
            zones.append(CGPoint(x: 350, y: 47))
            zones.append(CGPoint(x: 491.421, y: 388.421))
            zones.append(CGPoint(x: 208.579, y: 388.421))
            zones.append(CGPoint(x: 491.421, y: 105.579))
            zones.append(CGPoint(x: 208.579, y: 105.579))
        }
     
        // Check Triangle
        if (isAlz && level >= 2 && level <= 5) {
            zones.append(CGPoint(x: 750, y: 250))
            zones.append(CGPoint(x: 650, y: 400))
            zones.append(CGPoint(x: 850, y: 400))
        }
        
        // Check Rectangle
        if (isAlz && level == 3) {
            zones.append(CGPoint(x: 750, y: 150))
            zones.append(CGPoint(x: 350, y: 150))
            zones.append(CGPoint(x: 350, y: 350))
            zones.append(CGPoint(x: 750, y: 350))
        }

        // Check Alz Prism
        if (isAlz && level >= 4){
            zones.append(CGPoint(x: 350, y: 350))
            zones.append(CGPoint(x: 350, y: 150))
            zones.append(CGPoint(x: 420, y: 60))
            zones.append(CGPoint(x: 820, y: 60))
            zones.append(CGPoint(x: 820, y: 260))
            zones.append(CGPoint(x: 750, y: 350))
            zones.append(CGPoint(x: 750, y: 150))
            zones.append(CGPoint(x: 820, y: 60))
            zones.append(CGPoint(x: 750, y: 150))
            zones.append(CGPoint(x: 350, y: 150))
            zones.append(CGPoint(x: 350, y: 350))
            zones.append(CGPoint(x: 750, y: 350))
        }
        
        // Check Blob
        if (isAlz && level == 5) {
            radius = 20
            zones.append(CGPoint(x: 500, y: 230))
            zones.append(CGPoint(x: 200, y: 130))
            zones.append(CGPoint(x: 280, y: 350))
            zones.append(CGPoint(x: 320, y: 300))
            zones.append(CGPoint(x: 380, y: 400))
        }
        
        return checkZones(data: data, zones: zones, radius: radius)
    }

    func checkZones(data: DrawingData, zones: [CGPoint], radius: CGFloat) -> Bool {
        var checkList = Array(repeating: false, count: zones.count)
        for point in data.coordinates {
            for index in 0...zones.count - 1{
                if (!checkList[index] && (point.x-zones[index].x)*(point.x-zones[index].x) + (point.y-zones[index].y)*(point.y-zones[index].y) <= radius*radius) {
                    checkList[index] = true
                }
            }
        }
        for element in checkList {
            if (!element) {
                print("Drawing Incomplete")
                return false
            }
        }
        print("Drawing Complete")
        return true
    }

    // Distance from a point (p1) to line l1 l2
    func distanceFromPoint(p: CGPoint, toLineSegment v: CGPoint, and w: CGPoint) -> CGFloat {
        let pv_dx = p.x - v.x
        let pv_dy = p.y - v.y
        let wv_dx = w.x - v.x
        let wv_dy = w.y - v.y

        let dot = pv_dx * wv_dx + pv_dy * wv_dy
        let len_sq = wv_dx * wv_dx + wv_dy * wv_dy
        let param = dot / len_sq

        var int_x, int_y: CGFloat // intersection of normal to vw that goes through p

        if param < 0 || (v.x == w.x && v.y == w.y) {
            int_x = v.x
            int_y = v.y
        } else if param > 1 {
            int_x = w.x
            int_y = w.y
        } else {
            int_x = v.x + param * wv_dx
            int_y = v.y + param * wv_dy
        }

        // Components of normal
        let dx = p.x - int_x
        let dy = p.y - int_y

        return sqrt(dx * dx + dy * dy)
    }

    // returns polar angle in radians
    func calcTheta(p: CGPoint) -> CGFloat{
        var theta : CGFloat = 0
        if (p.x >= 0 && p.y >= 0) {
            if (p.x == 0) {
                theta = atan(p.y/(p.x+0.000001))
            }
            else {
                theta = atan(p.y/(p.x))
            }
        }
        else if (p.x < 0) {
            theta = CGFloat.pi + atan(p.y/p.x)
        }
        else {
            theta = 2*CGFloat.pi + atan(p.y/p.x)
        }
        return theta
    }

    func distanceToCircle(p: CGPoint, center: CGPoint, radius: CGFloat) -> CGFloat {
        return abs(sqrt((p.x-center.x)*(p.x-center.x) + (p.y-center.y)*(p.y-center.y)) - radius)
    }

    func distanceToEllipse(p: CGPoint, center: CGPoint, x_radius: CGFloat, y_radius: CGFloat) -> CGFloat {
        let theta = calcTheta(p: CGPoint(x: p.x+center.x, y: p.y+center.y))
        let x_coord = center.x + x_radius*cos(theta)
        let y_coord = center.y + y_radius*sin(theta)
        return sqrt((p.x-x_coord)*(p.x-x_coord) + (p.y-y_coord)*(p.y-y_coord))
    }

    // y = ax^2 + bx + c
    func distanceToParabola(p: CGPoint, a: Double, b: Double, c: Double) -> CGFloat {
        let x_coord : Double = solveCubicEquation(a: 2*a*a, b: 3*b*a, c: b*b+2*c*a-2*a*Double(p.y)+1, d: c*b-b*Double(p.y)-Double(p.x))[0]
        let y_coord : Double = a*x_coord*x_coord + b*x_coord + c
        return CGFloat(sqrt((Double(p.x)-x_coord)*(Double(p.x)-x_coord) + (Double(p.y)-y_coord)*(Double(p.y)-y_coord)))
    }

    // ax^3 + bx^2 + cx + d = 0, only real solutions
    func solveCubicEquation(a: Double, b: Double, c: Double, d: Double) -> [Double] {
        if a == 0.0 {
            return solveQuadraticEquation(a: b, b: c, c: d)
        } else {
            // should be delete `a`
            let A = b / a
            let B = c / a
            let C = d / a
            return solveCubicEquation(A: A, B: B, C: C)
        }
    }

    // x^3 + Ax^2 + Bx + C = 0
    func solveCubicEquation(A: Double, B: Double, C: Double) -> [Double] {
        if A == 0.0 {
            return solveCubicEquation(p: B, q: C)
        } else {
            // x = X - A/3 (completing the cubic. should be delete `Ax^2`)
            let p = B - (pow(A, 2.0) / 3.0)
            let q = C - ((A * B) / 3.0) + ((2.0 / 27.0) * pow(A, 3.0))
            let roots = solveCubicEquation(p: p, q: q)
            return roots.map { $0 - A/3.0 }
        }
    }

    // x^3 + px + q = 0
    func solveCubicEquation(p: Double, q: Double) -> [Double] {
        let p3 = p / 3.0
        let q2 = q / 2.0
        let discriminant = pow(q2, 2.0) + pow(p3, 3.0) // D: discriminant
        if discriminant < 0.0 {
            // three possible real roots
            let r = sqrt(pow(-p3, 3.0))
            let t = -q / (2.0 * r)
            let cosphi = min(max(t, -1.0), 1.0)
            let phi = acos(cosphi)
            let c = 2.0 * cuberoot(r)
            let root1 = c * cos(phi/3.0)
            let root2 = c * cos((phi+2.0*Double.pi)/3.0)
            let root3 = c * cos((phi+4.0*Double.pi)/3.0)
            return [root1, root2, root3]
        } else if discriminant == 0.0 {
            // three real roots, but two of them are equal
            let u: Double
            if q2 < 0.0 {
                u = cuberoot(-q2)
            } else {
                u = -cuberoot(q2)
            }
            let root1 = 2.0 * u
            let root2 = -u
            return [root1, root2]
        } else {
            // one real root, two complex roots
            let sd = sqrt(discriminant)
            let u = cuberoot(sd - q2)
            let v = cuberoot(sd + q2)
            let root1 = u - v
            return [root1]
        }
    }

    func cuberoot(_ v: Double) -> Double {
        let c = 1.0 / 3.0
        if v < 0.0 {
            return -pow(-v, c)
        } else {
            return pow(v, c)
        }
    }

    // ax^2 + bx + c = 0
    func solveQuadraticEquation(a: Double, b: Double, c: Double) -> [Double] {
        if a == 0.0 {
            let root = solveLinearEquation(a: b, b: c)
            return [root].filter({ !$0.isNaN })
        }

        let discriminant = pow(b, 2.0) - (4.0 * a * c) // D = b^2 - 4ac
        if discriminant < 0.0 {
            return []
        } else if discriminant == 0.0 {
            let root = -b / (2.0 * a)
            return [root]
        } else {
            let d = sqrt(discriminant)
            let root1 = (-b + d) / (2.0 * a)
            let root2 = (-b - d) / (2.0 * a)
            return [root1, root2]
        }
    }

    // ax + b = 0
    func solveLinearEquation(a: Double, b: Double) -> Double {
        if a == 0.0 {
            return .nan
        } else {
            let root = -b / a
            return root
        }
    }
}
