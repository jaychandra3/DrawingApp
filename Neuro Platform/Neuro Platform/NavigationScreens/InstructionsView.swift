//
//  InstructionsView.swift
//  Neuro Platform
//
//  Created by user175482 on 12/28/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI

// Barebones Instruction View : TODO
struct InstructionsView: View {
    var body: some View {
        VStack {
            Text("Instructions")
                .textStyle(TitleTextStyle())
            Text("Instructions go here, bahoomda.")
                .textStyle(BodyTextStyle())
            Spacer()
        }
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}
