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
// used in DrawingView finishInfo and DataObjects finishDrawing functions
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

// Original app root directory URL
func getDocumentsDirectoryRoot() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
}

// Updates the URL path to create differently named directories every time we export (named based on date & time of export)
func updateDocumentsPath(createDirectory: Bool) -> URL {
    // root documents directory
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    if (createDirectory) {
        // get current date to add as name of new directory in documents directory (to export)
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM-d-y-HH:mm"
        let folderName: String = formatter.string(from: now)
        
        do {
            try FileManager.default.createDirectory(at: path.appendingPathComponent(folderName), withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Could not create directory \(folderName) at \(path)")
        }
        
        let newRootDirectory = path.appendingPathComponent(folderName, isDirectory: true)
        
        let urls : [URL]
        do {
            try urls = FileManager.default.contentsOfDirectory(at: getDocumentsDirectoryRoot(), includingPropertiesForKeys: nil, options: .skipsSubdirectoryDescendants)
        } catch {
            print("urls array did not get initialized")
            urls = [URL]()
        }

        for url in urls {
            let newURL = newRootDirectory.appendingPathComponent(url.lastPathComponent)
            do {
                try FileManager.default.moveItem(at: url, to: newURL)
            } catch {
                print("Could not move item from \(url) to \(newURL)")
            }
        }
        
        return newRootDirectory
    } else {
        return path
    }
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
        //print("\(url)")
        let temp = FileManagerItemView(label: url.lastPathComponent, url: url, isDirectory: url.hasDirectoryPath)
        items.append(temp)
    }
    
    return items
}
