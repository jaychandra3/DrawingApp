//
//  Step.swift
//  Neuro Platform
//
//  Created by Jason Shang on 3/31/21.
//  Copyright © 2021 NDDP. All rights reserved.
//


import Foundation
import SwiftUI

struct Step: Hashable, Codable, Identifiable {
    var id: Int
    var step: String
    var stepLabel: String
    var shape: String
    var instructions: String
}

