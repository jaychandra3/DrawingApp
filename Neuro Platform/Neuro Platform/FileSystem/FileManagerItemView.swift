//
//  FileManagerItemView.swift
//  Neuro Platform
//
//  Created by user175482 on 7/31/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI

// This is the items in the file system like a folder/file
// it gets passed a url to the specific file/folder and
// sets up the button action based on file type (open folder/open file)
struct FileManagerItemView: View {
    var label : String
    var url : URL
    var isDirectory : Bool
    
    var body: some View {
        ZStack {
            if isDirectory {
                NavigationLink(destination: FileManagerView(url: self.url)) {
                    Rectangle()
                    .foregroundColor(.gray)
                    .cornerRadius(20)
                }
            } else {
                HStack {
                
                    NavigationLink(
                        destination: TextFileView(url : self.url)) {
                        Rectangle()
                        .foregroundColor(.gray)
                        .cornerRadius(20)
                    }
                    Button("Open File", action: {})
                }
            }
            HStack {
                if isDirectory {
                    Image(systemName: "folder")
                    .font(.system(size: 32, weight: .ultraLight))
                    .padding(.leading)
                } else {
                    Image(systemName: "doc.plaintext")
                    .font(.system(size: 32, weight: .ultraLight))
                    .padding(.leading)
                }
                
                Text(label)
                Spacer()
            }
            
        }
        .frame(minHeight: 50, maxHeight: 50)
        .padding(.horizontal)
    }
}
