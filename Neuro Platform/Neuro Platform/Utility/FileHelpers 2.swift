//
//  FileHelpers.swift
//  Neuro Platform
//
//  Created by user175482 on 7/27/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import Foundation
import SwiftUI

// get URL of folder and/or filename passed in
func getDocumentsDirectory(foldername foldercomponent : String?, filename pathcomponent : String) -> URL {
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        .first!
    
    if let folder = foldercomponent {
        do {
            try FileManager.default.createDirectory(at: path.appendingPathComponent(folder), withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Could not create directory \(folder) at \(path)")
            print(error)
        }
        return path.appendingPathComponent(folder, isDirectory: true)
            .appendingPathComponent(pathcomponent, isDirectory: false)
    } else {
        return path.appendingPathComponent(pathcomponent, isDirectory: false)
    }
}

// App root directory URL, only really called in above function getDocumentsDirectory
func getDocumentsDirectoryRoot() -> URL {
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    .first!
    
    return path
}

// Generate FileManagerItemView for each file/folder in the given URL
// which is used for displaying the files to user
func generateFileItemViews(url : URL = getDocumentsDirectoryRoot()) -> [FileManagerItemView] {
    var items = [FileManagerItemView]()
    let urls : [URL]
    do {
        try urls = FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsSubdirectoryDescendants)
    } catch {
        print(error)
        urls = [URL]()
    }
    
    for url in urls {
        let temp = FileManagerItemView(label: url.lastPathComponent, url: url, isDirectory: url.hasDirectoryPath)
        items.append(temp)
    }
    
    return items
}
