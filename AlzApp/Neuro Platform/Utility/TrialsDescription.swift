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
    // case animation_screen
    case encoding_step1
    case encoding_step2
    case encoding_step3
    case distractor_step
    case retrieval_step1
    case retrieval_step2
    case multiple_choice
    // case retrieval_step3 - this is the multiple choice question
}

enum TrialShape {
    case circle
    case spirosquare
    case rectangle
    case multipleshapes
    case archspiral
    case multipleshapesvertices
}

enum LevelNum {
    case level1
    case level2
    case level3
    case level4
    case level5
}

/*
// this trialList is for Elias' original version
var trialList : [(TrialType, TrialShape)] = [
    (.accurate, .archspiral), (.fast, .multipleshapes), (.fast, .spirosquare), (.accurate, .rectangle)
]
*/

var trialList: [TrialType] = [
    .practice_screen, .encoding_step1, .encoding_step2, .encoding_step3, .distractor_step, .retrieval_step1, .retrieval_step2, .multiple_choice
]

var levelList: [LevelNum] = [
    .level1, .level2, .level3, .level4, .level5
]
