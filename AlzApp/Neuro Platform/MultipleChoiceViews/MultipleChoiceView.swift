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
    @Binding var finalShape: String
    var numAnswers: Int
    
    @State var multipleChoiceContent: [String:[AnswerChoice]] = [
        // Parkinson's shapes:
        "circle": [AnswerChoice(image:Image("circle")), AnswerChoice(image:Image("ellipse_x_major_axis")), AnswerChoice(image:Image("ellipse_x_major_axis2")), AnswerChoice(image:Image("ellipse_y_major_axis"))],
        "infinity_symbol": [],
        "prism": [],
        "arch_spiral": [AnswerChoice(image:Image("arch_spiral_cclock")), AnswerChoice(image:Image("arch_spiral_cclock_diff_start_pt")), AnswerChoice(image:Image("arch_spiral_correct")), AnswerChoice(image:Image("arch_spiral_diff_start_pt"))],
        "spirograph": []
        
        // Alzheimer's shapes:
    ]
    
    
    @State var circleChoices: [AnswerChoice] = [AnswerChoice(image:Image("circle")), AnswerChoice(image:Image("ellipse_x_major_axis")), AnswerChoice(image:Image("ellipse_x_major_axis2")), AnswerChoice(image:Image("ellipse_y_major_axis"))]

    var body: some View {
        //var selected: Bool = true
        @State var answerChoices: [AnswerChoice] = multipleChoiceContent[finalShape] ?? []
        VStack (alignment: .leading) {
            Spacer()
            Text("Retrieval Step 2 - Multiple Choice").font(.system(size:35)).bold().padding()
            Text("What was the final shape you drew?").font(.system(size:20)).padding()
            
            List {
                ForEach(0..<answerChoices.count) {index in
                    HStack {
                        
                        Button(action: {
                            answerChoices[index].isSelected = answerChoices[index].isSelected ? false:true
                            //selected = answerChoices[index].isSelected
                            print(answerChoices[index].isSelected)
                            //print(selected)
                            //self.numAnswers += 1
                        }) {
                            HStack {
                                if answerChoices[index].isSelected {
                                    Image(systemName: "checkmark.circle.fill").resizable().frame(width:35, height:35)
                                            .foregroundColor(.green)
                                            .animation(.easeIn)
                                    Text("isSelected = true")
                                } else {
                                    Image(systemName: "circle").resizable().frame(width:35, height:35).foregroundColor(.primary).animation(.easeOut)
                                    Text("isSelected = false")
                                }
                                answerChoices[index].image.resizable().scaledToFit().frame(width:250, height:250)
                                /*Button(action: {
                                    print(answerChoices[index])
                                }) { Text("Print array") }*/
                            }
                        }.buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
            Spacer()
        }
    }
}

/*
struct MultipleChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleChoiceView(finalShape:"circle", numAnswers: 1)
    }
}*/
