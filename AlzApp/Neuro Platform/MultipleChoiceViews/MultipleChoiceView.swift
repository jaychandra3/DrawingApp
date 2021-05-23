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

struct MultipleChoiceView: View {
    var finalShape: String
    var numAnswers: Int
    
    static var multipleChoiceContent: [String:Array<AnswerChoice>] = [
        "circle": [AnswerChoice(image:Image("circle")), AnswerChoice(image:Image("ellipse_x_major_axis")), AnswerChoice(image:Image("ellipse_x_major_axis2")), AnswerChoice(image:Image("ellipse_y_major_axis"))]
    ]
    
    var body: some View {
        VStack {
            var answerChoices = MultipleChoiceView.multipleChoiceContent[finalShape]!
            ForEach(0..<answerChoices.count) {index in
                HStack {
                    Button(action: {
                        answerChoices[index].isSelected = answerChoices[index].isSelected ? false:true
                        //self.numAnswers += 1
                    }) {
                        HStack {
                            if answerChoices[index].isSelected {
                                Image(systemName: "checkmark.circle.fill").resizable().frame(width:35,height:35)
                                        .foregroundColor(.green)
                                        .animation(.easeIn)
                            } else {
                                Image(systemName: "circle").resizable().frame(width:35,height:35).foregroundColor(.primary).animation(.easeOut)
                            }
                            answerChoices[index].image.resizable().scaledToFit().frame(width:250, height:250)
                        }
                    }.buttonStyle(BorderlessButtonStyle())
                }
            }
        }
    }
}

struct MultipleChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleChoiceView(finalShape:"circle", numAnswers: 1)
    }
}
