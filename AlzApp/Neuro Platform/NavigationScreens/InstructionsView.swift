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
        ScrollView {
            VStack {
                Spacer()
                Text("Instructions")
                    .textStyle(TitleTextStyle()).padding()
                Text("1. Select the appropriate test to be administered (Parkinson’s or Alzheimer’s) based on the patient demographic.\n\n2. Enter the patient information (ID, dominant hand) into the fields and verify that the information is correct.\n\n3. Press “Start Task” to continue.\n\n4. Hand the device to the patient and help them draw using the Apple pencil on the practice screen. Remind patient to treat the iPad just like a piece of paper, and write naturally.\n\n5. Read and execute the instructions displayed on each step, using the “Next Trial” button to proceed to the next step.\n\n6. Press “Finish Test” once the last step is complete to return to the Home Screen.\n\n7. Press “View Patient Records” to access patient information and test data.\n\n8. Press “Export All Files” to transfer the patient records to local storage. ")
                    .textStyle(BodyTextStyle()).padding()
                Spacer()
            }
        }
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}
