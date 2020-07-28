//
//  DrawingView.swift
//  Neuro Platform
//
//  Created by user175482 on 6/18/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI

struct DrawingView: View {
    @State private var currentDrawing : Drawing = Drawing()
    @State private var drawings : [Drawing] = [Drawing]()
    @State private var color : Color = Color.black
    @State private var lineWidth : CGFloat = 3.0
    let data = DrawingData()
    
    let circle : some Shape = Circle()
        .stroke(lineWidth: 3)
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                DrawingPad(currentDrawing: $currentDrawing,
                           drawings: $drawings)
                HStack {
                    Spacer()
                    circle
                        .opacity(0.5)
                    Spacer()
                }
                
                TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: data)
                    .opacity(0.1)
                
            }
            Spacer()
            HStack {
                Button(action: {self.drawings = [Drawing]()}) {
                    Text("Clear Drawings").foregroundColor(.white)
                }
                Spacer()
                Button(action: {self.data.finishDrawing()}) {
                    Text("Finish Drawing").foregroundColor(.white)
                }
            }
            .padding()
            .background(Rectangle().foregroundColor(.black))
            .cornerRadius(5)
            Spacer()
        }
    }
    
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView()
    }
}
