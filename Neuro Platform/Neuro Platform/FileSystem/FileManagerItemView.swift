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
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
                .cornerRadius(20)
            HStack {
                Image(systemName: "folder")
                    .font(.system(size: 32, weight: .ultraLight))
                    .padding(.leading)
                Text(label)
                Spacer()
            }
            
        }
        .frame(minHeight: 50, maxHeight: 50)
        .padding(.horizontal)
    }
}

struct FileManagerItemView_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerItemView(label: "Folder Name Here")
    }
}
