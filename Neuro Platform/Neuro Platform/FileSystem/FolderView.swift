//
//  FolderView.swift
//  Neuro Platform
//
//  Created by user175482 on 9/19/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI

struct FolderView: View {
    var label : String
    var url : URL?
    let items : [FileManagerItemView]
    
    init(label title : String, url : URL) {
        self.label = title
        self.url = url
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

struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        FolderView(label: "Ur mum", url: URL(string: "www.google.com")!)
    }
}
