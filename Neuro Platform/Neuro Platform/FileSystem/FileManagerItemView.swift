//
//  FileManagerItemView.swift
//  Neuro Platform
//
//  Created by user175482 on 7/31/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI

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
                Rectangle()
                .foregroundColor(.gray)
                .cornerRadius(20)
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
