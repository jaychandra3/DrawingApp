//
//  TouchCapture.swift
//  Neuro Platform
//
//  Created by user175482 on 7/14/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI

struct TouchCaptureView: UIViewControllerRepresentable {
    class Coordinator : NSObject,TouchCaptureViewDelegate {
        var parent : TouchCaptureView
        
        init(_ parent : TouchCaptureView) {
            self.parent = parent
        }
        
        func didStartDrag(_ sender: TouchCaptureViewController, _ touch : UITouch) {
            parent.continueDrawing(point: touch.location(in: sender.view))
        }
        
        func didDrag(_ sender: TouchCaptureViewController, _ touch : UITouch) {
            parent.continueDrawing(point: touch.location(in: sender.view))
        }
        
        func didFinishDrag(_ sender: TouchCaptureViewController, _ touch : UITouch) {
            parent.finishDrawing(point: touch.location(in: sender.view))
        }
    }
    
    @Binding var currentDrawing : Drawing
    @Binding var drawings : [Drawing]
    
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
    
    public func continueDrawing(point : CGPoint) {
       //        user.update(value: value)
               let currentPoint = point
       //        if currentPoint.y >= 0
       //            && currentPoint.y < geometry.size.height {
                   currentDrawing.points.append(currentPoint)
       //        }
    }
           
    public func finishDrawing(point : CGPoint) {
    //        self.user.update(value: value)
        drawings.append(currentDrawing)
        currentDrawing = Drawing()
    }
    
}
