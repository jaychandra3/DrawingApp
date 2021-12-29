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
    // for adaptive parkinson's & alzheimer's tests
    case fast
    case emptyPadDrawing
    //case accurate
    case practice_screen
    // case animation_screen
    case encoding_step1
    case encoding_step2
    case encoding_step3
    case distractor_step1
    case distractor_step2
    case distractor_step3
    case retrieval_step1
    case multiple_choice
    
    // for non-adaptive tests
    case lvl1_normal
    case lvl1_fast
    case lvl1_no_temp
    case lvl2_normal
    case lvl2_fast
    case lvl2_no_temp
    case lvl3_normal
    case lvl3_fast
    case lvl3_no_temp
    case lvl4_normal
    case lvl4_fast
    case lvl4_no_temp
    case lvl5_normal
    case lvl5_fast
    case lvl5_no_temp
}

enum TrialShape {
    case circle
    case spirosquare
    case rectangle
    case multipleshapes
    case archspiral
}

enum LevelNum {
    case level1
    case level2
    case level3
    case level4
    case level5
}

var trialListParkinson: [TrialType] = [
    .practice_screen, .encoding_step1, .encoding_step2, .fast, .encoding_step3
]

var trialListAlz: [TrialType] = [
    .practice_screen, .encoding_step1, .encoding_step2, .encoding_step3, .emptyPadDrawing, .distractor_step1, .distractor_step2, .distractor_step3, .retrieval_step1, .multiple_choice
]

var trialListNonAdap: [TrialType] = [
    .lvl1_normal, .lvl1_normal, .lvl1_fast, .lvl1_no_temp,
    .lvl2_normal, .lvl2_normal, .lvl2_fast, .lvl2_no_temp,
    .lvl3_normal, .lvl3_normal, .lvl3_fast, .lvl3_no_temp,
    .lvl4_normal, .lvl4_normal, .lvl4_fast, .lvl4_no_temp,
    .lvl5_normal, .lvl5_normal, .lvl5_fast, .lvl5_no_temp
]

var levelList: [LevelNum] = [
    .level1, .level2, .level3, .level4, .level5
]
