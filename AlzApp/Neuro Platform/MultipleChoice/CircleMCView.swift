//
//  MCView.swift
//  Neuro Platform
//
//  Created by Jason Shang on 5/21/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

import SwiftUI

struct MCView: View {
    @State private var results: [String:Bool] = MultipleChoiceContent.
    
    var body: some View {
        VStack {
            GridView(columns: 1, list: MultipleChoiceContent.circleChoices) { imageName in
                HStack {
                    Image(imageName)
                    Toggle(imageName, isOn: self.binding(for: imageName)).labelsHidden()
                }
            }
        }
    }
    
    private func binding(for key: String) -> Binding<Bool> {
        return .init(
            get: { self.results[key, default: false]},
            set: { self.results[key] = $0 })
    }
}

struct MCView_Previews: PreviewProvider {
    static var previews: some View {
        MCView()
    }
}
