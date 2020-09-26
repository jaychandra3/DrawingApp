//
//  FileHelpers.swift
//  Neuro Platform
//
//  Created by user175482 on 7/27/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import Foundation
import SwiftUI

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

func getDocumentsDirectoryRoot() -> URL {
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    .first!
    
    return path
}

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
