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
}

/*
// this trialList is for Elias' original version
var trialList : [(TrialType, TrialShape)] = [
    (.accurate, .archspiral), (.fast, .multipleshapes), (.fast, .spirosquare), (.accurate, .rectangle)
]
*/

// this trialList is for Jason's new implemented version (integrating JSON); incomplete right now because we don't have that many custom shapes yet
var trialList: [TrialType] = [
    .practice_screen, .encoding_step1, .encoding_step2, .encoding_step3, .distractor_step, .retrieval_step1, .retrieval_step2, .multiple_choice
]
