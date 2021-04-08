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
    case fast
    case accurate
}

enum TrialShape {
    case circle
    case spirosquare
    case rectangle
    case multipleshapes
    case archspiral
}

var trialList : [(TrialType, TrialShape)] = [
    (.accurate, .archspiral), (.fast, .multipleshapes), (.fast, .spirosquare), (.accurate, .rectangle)
]
