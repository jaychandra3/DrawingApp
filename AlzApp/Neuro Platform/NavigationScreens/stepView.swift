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
    var currentStep: Step
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                // Text(verbatim: currentStep.stepLabel).bold().font(.system(size: 35))
                Spacer()
            }.padding(.bottom, 25)
            Text("Instructions").bold().font(.system(size: 28)).padding(.bottom, 15)
            // Text(currentStep.instructions).font(.system(size: 25))
            Text("Hello")
        }.padding()
    }
}

struct stepView_Previews: PreviewProvider {
    static var previews: some View {
        stepView(currentStep: stepList[0])
    }
}
