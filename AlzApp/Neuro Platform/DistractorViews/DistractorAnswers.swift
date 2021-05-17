//
//  DistractorAnswers.swift
//  Neuro Platform
//
//  Created by Nicole Yu on 17/5/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

import Foundation

struct DistractorAnswers {
    static var step1: [Int] {
        get {
            var answers: [Int] = []
            
            for i in stride(from: 100, to: 0, by: -7) {
                answers.append(i)
            }
            
            return answers
        }
    }
}
