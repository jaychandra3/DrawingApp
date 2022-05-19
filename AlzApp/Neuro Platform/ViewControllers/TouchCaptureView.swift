//
//  TouchCapture.swift
//  Neuro Platform
//
//  Created by user175482 on 7/14/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI
/**
 UIKit wrapper for capturing UITouch information so we can collect necessary
 apple pencil data such as force and azimuth. Might not be necessary
 with future SwiftUI versions
 */
struct TouchCaptureView: UIViewControllerRepresentable {
    class Coordinator : NSObject,TouchCaptureViewDelegate {
        var parent : TouchCaptureView
        
        init(_ parent : TouchCaptureView) {
            self.parent = parent
        }
        
        func didStartDrag(_ sender: TouchCaptureViewController, _ touch : UITouch) {
            if (touch.type != .pencil) {
                //return
            }
            parent.data.update(value : touch, view : sender.view)
            parent.continueDrawing(point: touch.location(in: sender.view), bounds: sender.view.bounds)
        }
        
        func didDrag(_ sender: TouchCaptureViewController, _ touch : UITouch) {
            if (touch.type != .pencil) {
                //return
            }
            parent.data.update(value : touch, view : sender.view)
            parent.continueDrawing(point: touch.location(in: sender.view), bounds: sender.view.bounds)
        }
        
        func didFinishDrag(_ sender: TouchCaptureViewController, _ touch : UITouch) {
            if (touch.type != .pencil) {
                //return
            }
            parent.data.update(value: touch, view: sender.view)
            parent.finishDrawing(point: touch.location(in: sender.view), bounds : sender.view.bounds)
        }
    }
    
    @Binding var currentDrawing : Drawing
    @Binding var drawings : [Drawing]
    @Binding var data : DrawingData
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> TouchCaptureViewController {
        let controller = TouchCaptureViewController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: TouchCaptureViewController, context: Context) {
        
    }
    
    public func continueDrawing(point : CGPoint, bounds : CGRect) {
        if point.y >= 0
            && point.y < bounds.height {
                currentDrawing.points.append(point)
        } else {
            finishDrawing(point: nil, bounds: bounds)
        }

    }
           
    public func finishDrawing(point : CGPoint?, bounds : CGRect) {
        if let p = point {
            currentDrawing.points.append(p)
        }
        drawings.append(currentDrawing)
        currentDrawing = Drawing()
    }
    
}
