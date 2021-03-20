//
//  TextFileView.swift
//  Neuro Platform
//
//  Created by user175482 on 9/26/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI
// Prints file contents onto a view
struct TextFileView: View {
    let content : String
    
    init (url : URL? = nil) {
        if let urlval = url {
            do {
                content = try String(contentsOf: urlval, encoding: .utf8)
            } catch {
                print(error)
                content = error.localizedDescription
            }
        } else {
            content = "Error reading file from storage"
        }
    }
    
    var body: some View {
        ScrollView {
            Text(content)
        }

    }
}
