//
//  DrawingView.swift
//  Neuro Platform
//
//  Created by user175482 on 6/13/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI

struct Drawing {
    var points: [CGPoint] = [CGPoint]()
}

struct DrawingView: View {
    
    @State private var currentDrawing : Drawing = Drawing()
    @State private var drawings : [Drawing] = [Drawing]()
    @State private var color : Color = Color.black
    @State private var lineWidth : CGFloat = 3.0
    
    var body: some View {
        Text("HelloWorld")

    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView()
    }
}
