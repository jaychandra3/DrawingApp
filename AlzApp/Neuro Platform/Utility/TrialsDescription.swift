//
//  TrialsDescription.swift
//  Neuro Platform
//
//  Created by user175482 on 1/1/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

import Foundation
import SwiftUI

enum TrialType {
    //case fast
    //case accurate
    case practice_screen
    case encoding_step1
    case encoding_step2
}

enum TrialShape {
    case circle
    case spirosquare
    case rectangle
    case multipleshapes
    case archspiral
    case multipleshapesvertices
}

/*
// this trialList is for Elias' original version
var trialList : [(TrialType, TrialShape)] = [
    (.accurate, .archspiral), (.fast, .multipleshapes), (.fast, .spirosquare), (.accurate, .rectangle)
]
*/

// this trialList is for Jason's new implemented version (integrating JSON); incomplete right now because we don't have that many custom shapes yet
var trialList: [TrialType] = [
    .practice_screen, .encoding_step1, .encoding_step2
]
