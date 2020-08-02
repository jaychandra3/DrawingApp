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
            try FileManager.init().createDirectory(at: path.appendingPathComponent(folder), withIntermediateDirectories: true, attributes: nil)
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
