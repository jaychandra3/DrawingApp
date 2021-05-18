//
//  GridView.swift
//  Neuro Platform
//
//  Created by Nicole Yu on 17/5/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

import SwiftUI

/*
 This is a generic grid view that is populated from a given list
 Code reference: https://www.swiftpal.io/articles/how-to-create-a-grid-view-in-swiftui-for-ios-13
 */

struct GridView<Content: View, T: Hashable>: View {
    private let columns: Int
    private var list: [[T]] = []
    private let content: (T) -> Content
    
    init(columns: Int, list: [T], @ViewBuilder content:@escaping (T) -> Content) {
        self.columns = columns
        self.content = content
        self.setupList(list)
    }
    
    private mutating func setupList(_ list: [T]) {
        var column = 0
        var colIdx = 0
        
        for item in list {
            if colIdx < self.columns {
                if colIdx == 0 {
                    self.list.insert([item], at: column)
                    colIdx += 1
                } else {
                    self.list[column].append(item)
                    colIdx += 1
                }
            } else {
                column += 1
                self.list.insert([item], at: column)
                colIdx = 1
            }
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                ForEach(0 ..< self.list.count, id: \.self) { i in
                    HStack {
                        ForEach(self.list[i], id: \.self) { item in
                            self.content(item)
                                .padding()
                                .frame(width: UIScreen.main.bounds.size.width/CGFloat(self.columns))
                        }
                    }
                }
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    @State static var button100: Bool = false
    
    static var previews: some View {
        ScrollView() {
            GridView(columns: 5, list: DistractorAnswers.step1AnswerKey) { num in
                HStack {
                    Text(String(num)).font(.system(size:30))
                    Toggle(String(num), isOn: $button100).labelsHidden()
                }
            }
        }
    }
}
