//
//  FileManagerView.swift
//  Neuro Platform
//
//  Created by user175482 on 7/30/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI

struct FileManagerView: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(1...40, id: \.self) { value in
                    FileManagerItemView(label: "Folder \(value)")
                }
            }
        }
    }
}

struct FileManagerView_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerView()
    }
}
