//
//  ContentView.swift
//  Neuro Platform
//
//  Created by Jay Chandra on 6/13/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    @State private var canvasView = PKCanvasView()
    
    var body: some View {
        VStack {
            Text("PencilKit Canvas")

            CanvasView(canvasView: $canvasView)
                .aspectRatio(contentMode: ContentMode.fill)
                
                
            Spacer()
            Button(action: {self.canvasView.drawing = PKDrawing()}){
                ZStack {
                    Rectangle()
                        .frame(width: 250.0, height: 30.0)
                        .foregroundColor(.black)
                        .cornerRadius(5)
                        
                    Text("Clear Canvas")
                        .foregroundColor(.white)
                }
            }
//            Button(action: {
//                print(self.canvasView.gestureRecognizers)
//            }) {
//                ZStack {
//                    Rectangle()
//                        .frame(width: 250.0, height: 30.0)
//                        .foregroundColor(.black)
//                        .cornerRadius(5)
//
//                    Text("Log to Console")
//                        .foregroundColor(.white)
//                }
//            }
            Spacer()
//            Text("DrawView")
//            DrawingView()
//            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
