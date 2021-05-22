//
//  QuestionsView.swift
//  Neuro Platform
//
//  Created by Ash on 4/21/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

import SwiftUI

struct MultipleChoiceView: View {
    
}
/*
struct QuesInfo: Identifiable {
  let id: Int
  let question: String
  var answers: [Answer]
}

struct Answer: Identifiable {
  let id: Int
  let answer: String
  var isSelected: Bool
}

struct QuestionsView: View {
    @Binding var finalShape: String
    
    
    
    /*
  //@State var homeActive : Bool = false
    @State var quesInfoArr = [
    QuesInfo(id: 0, question: "What was the final shape you drew?",
      answers: [
        Answer(id: 0, answer: "Rectangle", isSelected: false),
        Answer(id: 1, answer: "Circle", isSelected: false),
        Answer(id: 2, answer: "Diamond", isSelected: false),
        Answer(id: 3, answer: "Triangle", isSelected: false)
    ]),
    ]*/

  var body: some View {
    VStack{
        Spacer()
        /*
        NavigationLink(
          destination: HomeView(),
          isActive: $homeActive,
          label: {
              EmptyView()
          }) */

      Text("Please answer the following question").textStyle(TitleTextStyle())

      ForEach(quesInfoArr) { question in
        Text(question.question)
        ForEach(question.answers) { answer in
            Button(action: {
              quesInfoArr[question.id].answers[answer.id].isSelected.toggle();
              next(id: question.id)}, label: {
            Text(answer.answer)
          }).buttonStyle(MainButtonStyle())
        }
      }
      Spacer()
    }
  }
    
    private func next(id: Int) {
      if (id + 1 == quesInfoArr.count) {
        for question in quesInfoArr {
          for answer in question.answers {
            if answer.isSelected {
              patientInfo += "Answer Choice: " + answer.answer + "\n"
              finishInfo(patient: patientID, patientInfoCSV: patientInfo)
            }
          }
        }
        //homeActive.toggle()
      }
      // else move to next question
    }
}

func finishInfo(patient: String, patientInfoCSV: String, formName : String = "patientInfo.csv") {
    let url : URL = getDocumentsDirectory(foldername: patient, filename: formName)
    do {
    let str : String = patientInfoCSV
        try str.write(to: url, atomically: true, encoding: .utf8)
        let input = try String(contentsOf: url)
        print(input)
    } catch {
        print("Failed to write to disk")
        print(error.localizedDescription)
    }
}

struct QuestionsView_Previews: PreviewProvider {
  static var previews: some View {
    QuestionsView()
  }
}
*/
