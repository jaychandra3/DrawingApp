//
//  ViewHelpers.swift
//  Neuro Platform
//
//  Created by user175482 on 8/4/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI

struct ErrorView: View {
    var errorDescription : String
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(.red)
                    .cornerRadius(20)
                Text(self.errorDescription)
            }
        .padding()
        }
    }
}

struct InstructionView : View {
    
    
    var body : some View {
        Text("Instructions")
            .font(.largeTitle)
            .multilineTextAlignment(.center)
    }
}

struct ViewHelpers_Previews: PreviewProvider {
    static var previews: some View {
//        ErrorView(errorDescription: "Testing error")
//        MyButton(action: {}, label: "button")
        InstructionView()
    }
}

