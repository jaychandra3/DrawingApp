//
//  Distractor3View.swift
//  Neuro Platform
//
//  Created by Jason Shang on 5/7/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

 // might be changing distractor step 3 altogether (syllables test might not be the test)
import SwiftUI

struct Distractor3View: View {
    /*
    @State var interestedNumber: Int
    @State var machineNumber: Int
    @State var perspective: Int
    @State var neglected: Int
    
    var body: some View {
        VStack {
            HStack {
                Text("Syllables of Interested: ")
                HStack {
                    Toggle("In", isOn: $buttonIn).labelsHidden()
                }
            }
        }
    }*/
    
    
    // MARK: Final data for analysis
    @State private var results: [String:Bool] = DistractorAnswers.step3InitResults
    
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
        return Double(score) / Double(self.results.count - 1) * Double(100)
    }
    
    var body: some View {
        VStack {
            GridView(columns: 1, list: DistractorAnswers.step3AnswerKey) { num in
                HStack {
                    Text(String(num)).font(.system(size:30))
                    Toggle(String(num), isOn: self.binding(for: String(num)))
                        // For debugging: print dictionary of results
                        .onReceive([self.results].publisher.first(), perform: { value in
//                            print(value)
                            DistractorAnswers.step3FinalResult = value
                            DistractorAnswers.step3FinalResult["score"] = scoreInPercent
//                            print(DistractorAnswers.step3FinalResult)
//                            print(scoreInPercent)
                        })
                        .labelsHidden()
                }
            }
            Text("Correct answers: \(score) / \(self.results.count - 1)").padding()
            HStack {
                Text("Recited in correct order?")
                Toggle("Recited in correct order?", isOn: self.binding(for: "inOrder"))
                    .onReceive([self.results].publisher.first(), perform: { value in
                        print(value)
                        DistractorAnswers.step3FinalResult = value
                    })
                    .labelsHidden()
            }.padding()
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

struct Distractor3View_Previews: PreviewProvider {
    static var previews: some View {
        Distractor3View()
    }
}

