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
        
        func didStartDrag(_ sender: TouchCaptureViewController) {
            print("started drag")
        }
        
        func didDrag(_ sender: TouchCaptureViewController) {
            print("dragging")
        }
        
        func didFinishDrag(_ sender: TouchCaptureViewController) {
            print("finished Drag")
        }
    }
    
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
    
}
