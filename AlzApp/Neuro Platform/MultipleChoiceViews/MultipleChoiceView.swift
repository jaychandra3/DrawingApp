//
//  MultipleChoiceView.swift
//  Neuro Platform
//
//  Created by Jason Shang on 5/23/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

import SwiftUI

struct AnswerChoice {
    var id = UUID()
    var image: Image
    var isSelected: Bool = false
}

struct MCQFinalAnswer {
    static var shape: String? = nil
    static var answer: Int? = nil
    static var correctAnswer: Int? = nil
}

struct MultipleChoiceView: View {
    var finalShape: String
    
    @State var multipleChoiceContent: [String:[AnswerChoice]] = [
        // Parkinson's shapes:
        "circle": [AnswerChoice(image:Image("circle")), AnswerChoice(image:Image("ellipse_x_major_axis")), AnswerChoice(image:Image("ellipse_x_major_axis2")), AnswerChoice(image:Image("ellipse_y_major_axis"))],
        "infinity_symbol": [],
        "prism": [],
        "arch_spiral": [AnswerChoice(image:Image("arch_spiral_cclock")), AnswerChoice(image:Image("arch_spiral_cclock_diff_start_pt")), AnswerChoice(image:Image("arch_spiral_correct")), AnswerChoice(image:Image("arch_spiral_diff_start_pt"))],
        "spirograph": []
        
        // Alzheimer's shapes:
    ]
    
    @State var currentChoiceIdx: Int? = nil

    var body: some View {
        VStack (alignment: .leading) {
            Spacer()
            Text("Retrieval Step 2 - Multiple Choice").font(.system(size:35)).bold().padding()
            Text("What was the final shape you drew?").font(.system(size:20)).padding()
            
            /// @Jason, I updated the values straight from multipleChoiceContent state variable. Previously, answerChoices wasn't a state variable so any updates won't re-render the view to display the content. I also made it such that only 1 option can be selected - nicole 🤟🏽
            
            List {
                ForEach(0..<multipleChoiceContent[finalShape]!.count) {index in
                    HStack {
                        
                        Button(action: {
                            // 1. If there is an existing option selected, deselect that option
                            if (currentChoiceIdx != nil) {
                                multipleChoiceContent[finalShape]![currentChoiceIdx!].isSelected.toggle()
                            }
                            
                            // 2. Toggle the selected option
                            multipleChoiceContent[finalShape]?[index].isSelected.toggle()
                            
                            // 3. Update the index of current selected option
                            currentChoiceIdx = index
                            
                            MCQFinalAnswer.shape = finalShape
                            MCQFinalAnswer.answer = index + 1
                        }) {
                            HStack {
                                if multipleChoiceContent[finalShape]![index].isSelected {
                                    Image(systemName: "checkmark.circle.fill").resizable().frame(width:35, height:35)
                                            .foregroundColor(.green)
                                            .animation(.easeIn)
//                                    Text("isSelected = true")
                                } else {
                                    Image(systemName: "circle").resizable().frame(width:35, height:35).foregroundColor(.primary).animation(.easeOut)
//                                    Text("isSelected = false")
                                }
                                multipleChoiceContent[finalShape]![index].image.resizable().scaledToFit().frame(width:250, height:250)
                            }
                        }.buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
            Spacer()
        }
    }
}

struct MultipleChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleChoiceView(finalShape: "circle")
    }
}
