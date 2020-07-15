//
//  TouchCapture.swift
//  Neuro Platform
//
//  Created by user175482 on 7/14/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI

struct TouchCaptureView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> TouchCaptureViewController {
        let controller = TouchCaptureViewController()
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: TouchCaptureViewController, context: Context) {
        
    }
    
}
