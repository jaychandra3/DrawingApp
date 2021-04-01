//
//  stepView.swift
//  Neuro Platform
//
//  Created by Jason Shang on 3/31/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

import SwiftUI
import Foundation
import CoreGraphics

struct stepView: View {
    /* stepString: Encoding Step OR Retrieval Step*/
    var stepString: String
    var instructions: String
    // var shape: Shape
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text(stepString).bold().font(.system(size: 35))
                Spacer()
            }.padding(.bottom, 25)
            Text("Instructions").bold().font(.system(size: 28)).padding(.bottom, 15)
            Text(instructions).font(.system(size: 25))
        }.padding()
    }
}

struct stepView_Previews: PreviewProvider {
    static var previews: some View {
        var instruction: String = "Trace the figure below as accurately as possible. Pay attention to the figure and the order of the strokes as described by the numbered arrows. "
        stepView(stepString: "Encoding Step", instructions: instruction)
    }
}
