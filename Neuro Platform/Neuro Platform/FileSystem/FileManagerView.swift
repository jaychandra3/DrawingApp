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
    @State private var isMovingSelection = false;
    
    init(url : URL? = nil) {
        if let urlval = url {
            items = generateFileItemViews(url: urlval)
        } else {
            items = generateFileItemViews()
        }
    }
    
    var body: some View {
        VStack {
            Text("Patients")
                .textStyle(TitleTextStyle())
            ScrollView {
                VStack {
                    ForEach(items, id: \.label) { item in
                        item
                    }
                }
            }
            .toolbar {
                Button("Export All Files", action : {isMovingSelection = true})
            }
            .fileMover(isPresented: $isMovingSelection, file: getDocumentsDirectoryRoot()) {
                if case .success = $0 {
                    
                } else {
                    // Handle Failure
                }
            }
        }
            
    }
}

