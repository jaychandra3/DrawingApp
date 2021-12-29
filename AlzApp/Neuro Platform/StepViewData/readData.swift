//
//  readInstructions.swift
//  Neuro Platform
//
//  Created by Jason Shang on 3/31/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

import Foundation

// var stepList: [Step] = load("stepInstruction.json")

// stepsList is the one we want to use (stepInstructions.json is the updated json file)
var steps: [Step] = load("stepinstructions.json")
var steps_alz: [Step] = load("stepInstructionsAlz.json")
var steps_non_adap: [Step] = load("stepInstructionsNonAdap.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
