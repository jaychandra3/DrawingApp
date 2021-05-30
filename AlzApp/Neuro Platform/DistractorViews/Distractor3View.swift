//
//  Distractor3View.swift
//  Neuro Platform
//
//  Created by Jason Shang on 5/7/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

import SwiftUI

struct Distractor3View: View {
    @State private var results: String = ""
    
    public struct CustomTextFieldStyle: TextFieldStyle {
        public func _body(configuration: TextField<Self._Label>) -> some View {
            configuration.padding(10).frame(height: 250).background(RoundedRectangle(cornerRadius:5).strokeBorder(Color.primary.opacity(0.5)))
        }
    }
    
    var body: some View {
        TextField("Record answers here, with each answer separated by a comma. (ex. idea,skin,water,diesel,brown) ", text: $results).textFieldStyle(CustomTextFieldStyle()).border(Color.black).font(Font.system(size:25)).padding().multilineTextAlignment(.leading)
    }
}

/*
// drag and drop
struct Distractor3View: View {
    @State private var words = ["Idea", "Skin", "Water", "Diesel", "Brown"]

    var body: some View {
        VStack (alignment: .leading) {
            Text("Instructor: Please drag the words below into the order the patient recited the words.").font(.system(size:25)).padding()
            List {
                ForEach(words, id: \.self) { word in
                    Text(word).font(.system(size:25))
                }.onMove(perform: move)
            }.listStyle(InsetGroupedListStyle())
            Spacer()
        }
    }

    func move(from source: IndexSet, to destination: Int) {
        words.move(fromOffsets: source, toOffset: destination)
        print(words)
    }
}
 */

/*
struct Distractor3View: View {
    
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
        return Double(score) / Double(self.results.count-1) * Double(100)
    }
    
    var body: some View {
        VStack {
            GridView(columns: 1, list: DistractorAnswers.step3AnswerKey) { num in
                HStack {
                    Text(String(num)).font(.system(size:30))
                    Toggle(String(num), isOn: self.binding(for: String(num)))
                        .onReceive([self.results].publisher.first(), perform: { value in
                            DistractorAnswers.step3FinalResult = value
                            DistractorAnswers.step3FinalResult["score"] = scoreInPercent
                        })
                        .labelsHidden()
                }
            }
            Text("Correct answers: \(score) / \(self.results.count)").padding()
            HStack {
                Text("All Recited in correct order?")
                Toggle("Recited in correct order?", isOn: self.binding(for: "inOrder"))
                    .onReceive([self.results].publisher.first(), perform: { value in
                        DistractorAnswers.step3FinalResult = value
                        DistractorAnswers.step3FinalResult["score"] = scoreInPercent
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
*/
 
struct Distractor3View_Previews: PreviewProvider {
    static var previews: some View {
        Distractor3View()
    }
}

