//
//  DistractorAnswers.swift
//  Neuro Platform
//
//  Created by Nicole Yu on 17/5/21.
//  Copyright © 2021 NDDP. All rights reserved.
//
import Foundation

struct DistractorAnswers {
    
    // MARK: [TODO] Final Results
    /**
     These variables should be populated when 'Next Trial' button is clicked for easy data access.
     */
    // Conceptually, this should be an instance variable (not static) ??? At risk of illegal overrides from other views.
    static var step1FinalResult: Dictionary<String, String> = [:]
    static var step2FinalResult: Dictionary<String, String> = [:]
    static var step3FinalResult: Dictionary<String, String> = [:]
    
    
    // MARK: Distractor Step 1
    
    static var step1AnswerKey: [Int] {
        get {
            var answers: [Int] = []
            
            for i in stride(from: 100, to: 0, by: -7) {
                answers.append(i)
            }
            
            return answers
        }
    }
    
    static var step1InitResults: [String:Bool] {
        get {
            var initialResults = [String:Bool]()
            
            for i in stride(from: 100, to: 0, by: -7) {
                initialResults[String(i)] = false
            }
            
            return initialResults
        }
    }
    
    static func calculateStep1Score(result: String) {
        let separators = CharacterSet(charactersIn: ",")
        let resultArray = result.components(separatedBy: separators)
        var score: Int = 0
        var checked: [String] = []
        
        print(resultArray)
        for res in resultArray {
            if step1AnswerKey.contains(Int(res) ?? -1) {
                if !checked.contains(res) {
                    score += 1
                    checked.append(res)
                }
            }
        }
        
        let scoreInPercent: Double = Double(score) / Double(step1AnswerKey.count) * Double(100)
        step1FinalResult = ["result": result, "score": String(scoreInPercent)]
    }
    
    
    // MARK: Distractor Step 2
    
    static var step2AnswerKey: [String] {
        get {
            let alphabet: Array<Character> = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
            var answers: [String] = []
            
            for (index, letter) in alphabet.enumerated() {
                answers.append(String(letter) + String(index + 1))
            }
            
            return answers
        }
    }
    
    static var step2InitResults: [String:Bool] {
        get {
            var initialResults = [String:Bool]()
            let answers = step2AnswerKey
            
            for answer in answers {
                initialResults[answer] = false
            }
            
            return initialResults
        }
    }
    
    static func calculateStep2Score(result: String) {
        let separators = CharacterSet(charactersIn: ",")
        let resultArray = result.components(separatedBy: separators)
        var score: Int = 0
        var checked: [String] = []
        
        for res in resultArray {
            if step2AnswerKey.contains(res.uppercased()) {
                if !checked.contains(res.uppercased()) {
                    score += 1
                    checked.append(res.uppercased())
                }
            }
        }
        
        let scoreInPercent: Double = Double(score) / Double(step2AnswerKey.count) * Double(100)
        step2FinalResult = ["result": result, "score": String(scoreInPercent)]
    }
    
    // MARK: Distractor Step 3
    
    static var step3AnswerKey: [String] {
        get {
            let words: Array<String> = ["idea", "skin", "water", "diesel", "brown"]
            return words
        }
    }
    
    static var step3InitResults: [String:Bool] {
        get {
            var initialResults = [String:Bool]()
            let answers = step3AnswerKey
            
            initialResults["inOrder"] = false
            
            for answer in answers {
                initialResults[answer] = false
            }
            
            return initialResults
        }
    }
    
    static func calculateStep3Score(result: String) {
        let separators = CharacterSet(charactersIn: ",")
        let resultArray = result.components(separatedBy: separators)
        var score: Int = 0
        var inOrder: Bool = true
        var checked: [String] = []
        
        for (index, res) in resultArray.enumerated() {
            if step3AnswerKey.contains(res.lowercased()) {
                if !checked.contains(res.lowercased()) {
                    score += 1
                    checked.append(res.lowercased())
                }
            }
            
            if (index < step3AnswerKey.count && res.lowercased() != step3AnswerKey[index]) {
                inOrder = false
            }
        }
        
        let scoreInPercent: Double = Double(score) / Double(step3AnswerKey.count) * Double(100)
        step3FinalResult = ["result": result, "score": String(scoreInPercent), "inOrder": String(inOrder)]
    }
}
