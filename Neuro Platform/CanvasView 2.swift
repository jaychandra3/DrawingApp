//
//  CanvasView.swift
//  Neuro Platform
//
//  Created by user175482 on 6/19/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {
    @Binding var canvasView : PKCanvasView
    
    func makeUIView(context: Context) -> PKCanvasView {
        self.canvasView.tool = PKInkingTool(.pen, color: .black, width: 15)
        
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
    }
}
