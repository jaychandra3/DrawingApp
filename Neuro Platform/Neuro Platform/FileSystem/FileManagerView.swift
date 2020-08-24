//
//  FileManagerView.swift
//  Neuro Platform
//
//  Created by user175482 on 7/30/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI

struct FileManagerView: View {
    let items : [FileManagerItemView]
    
    init() {
        items = generateFileItemViews()
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(items, id: \.label) { item in
                    item
                }
            }
        }
    }
}

