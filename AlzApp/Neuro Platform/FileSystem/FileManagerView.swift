//
//  FileManagerView.swift
//  Neuro Platform
//
//  Created by user175482 on 7/30/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI

// This view allows the user to browse the local file system
// and view the saved CSVs/folders. If adding stuff here, be
// careful of interaction with FileHelpers, definetely review
// iOS file system behavior a little first
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
            Text("Reminder: refresh the app before and after each export.").font(.system(size: 20))
            ScrollView {
                VStack {
                    ForEach(items, id: \.label) { item in
                        item
                    }
                }
            }
            .toolbar {
                Button("Export All Files", action : {
                        isMovingSelection = true
                        print("button is pressed - toggle to true")
                })
            }
            .fileMover(isPresented: $isMovingSelection, file: updateDocumentsPath(createDirectory: isMovingSelection)){ result in
                switch result {
                case .success(let url):
                    print("Saved to \(url)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

