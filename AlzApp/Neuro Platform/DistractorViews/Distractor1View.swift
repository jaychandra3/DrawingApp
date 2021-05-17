//
//  Distractor1View.swift
//  Neuro Platform
//
//  Created by Nathan on 5/7/21.
//  Copyright © 2021 NDDP. All rights reserved.
//
import SwiftUI

struct DistractorResults: Identifiable {
    let id: UUID = UUID()
    var num: Int = 0
    var isToggled = false
    
    init(num: Int) {
        self.num = num
    }
}

struct Distractor1View: View {
    @State var button100: Bool = false
    @State var results: Dictionary<Int, Bool> = [Int: Bool]()
    
    init() {
        // Set up results dictionary
        for num in DistractorAnswers.step1 {
            results[num] = false
        }
    }
    
    var body: some View {
        ScrollView() {
            GridView(columns: 5, list: DistractorAnswers.step1) { num in
                HStack {
                    Text(String(num)).font(.system(size:30))
                    // MARK: TODO - Implement the toggle
                    Toggle(String(num), isOn: $button100).labelsHidden()
                }
            }
        }
    }
}

struct Distractor1View_Previews: PreviewProvider {
    static var previews: some View {
        Distractor1View()
    }
}
