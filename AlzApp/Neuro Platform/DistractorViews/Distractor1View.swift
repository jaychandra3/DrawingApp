//
//  Distractor1View.swift
//  Neuro Platform
//
//  Created by Nathan on 5/7/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

import SwiftUI

struct Distractor1View: View {
    @State private var results: String = ""
    
    public struct CustomTextFieldStyle: TextFieldStyle {
        public func _body(configuration: TextField<Self._Label>) -> some View {
            configuration.padding(10).frame(height: 250).background(RoundedRectangle(cornerRadius:5).strokeBorder(Color.primary.opacity(0.5)))
        }
    }
    
    var body: some View {
        TextField("Record answers here, with each answer separated by commas. (ex. 100,93,86,79...) ", text: $results).textFieldStyle(CustomTextFieldStyle()).border(Color.black).font(Font.system(size:25)).padding().multilineTextAlignment(.leading)
    }
}

/*
struct Distractor1View: View {
    // MARK: Final data for analysis
    @State private var results: [String:Bool] = DistractorAnswers.step1InitResults
    
    // Computed property: Calculate score when results state changes
    var score: Int {
        var score: Int = 0
        for (_, value) in results {
            if value {
                score += 1
            }
        }
        
        return score
    }
    
    var scoreInPercent: Double {
        return Double(score) / Double(self.results.count) * Double(100)
    }
    
    var body: some View {
        VStack {
            GridView(columns: 5, list: DistractorAnswers.step1AnswerKey) { num in
                HStack {
                    Text(String(num)).font(.system(size:30))
                    Toggle(String(num), isOn: self.binding(for: String(num)))
                        .onReceive([self.results].publisher.first(), perform: { value in
                            DistractorAnswers.step1FinalResult = value
                            DistractorAnswers.step1FinalResult["score"] = scoreInPercent
                        })
                        .labelsHidden()
                }
            }
            Text("Correct answers: \(score) / \(self.results.count)")
        }
    }
    
    /**
     Bind the toggle to corresponding value in dictionary results instead of declaring multiple state variables
     Code reference: https://forums.swift.org/t/swiftui-how-to-use-dictionary-as-binding/34967
     */
    private func binding(for key: String) -> Binding<Bool> {
        return .init(
            get: { self.results[key, default: false]},
            set: { self.results[key] = $0 })
    }
}
*/

struct Distractor1View_Previews: PreviewProvider {
    static var previews: some View {
        Distractor1View()
    }
}
