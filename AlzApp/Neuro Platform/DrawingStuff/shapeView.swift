//
//  shapeView.swift
//  Neuro Platform
//
//  Created by Jason Shang on 5/5/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

import SwiftUI

struct shapeView: View {
    var shape: Shape
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Template: ").bold().font(.system(size:20)).padding(.top, 2)
            shape.stroke(lineWidth:3).scale(0.7).offset(x:-20, y:-225)
            Divider()
            Text("Your Drawing: ").bold().font(.system(size:20)).padding(.top, -50)
            ZStack {
                DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                shape.stroke(lineWidth:3).scale(0.75).offset(x:-20, y:-200)
                TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data).opacity(0.1)
            }.padding(.top, -10)
        }.padding()
    }
}

struct shapeView_Previews: PreviewProvider {
    static var previews: some View {
        shapeView()
    }
}
