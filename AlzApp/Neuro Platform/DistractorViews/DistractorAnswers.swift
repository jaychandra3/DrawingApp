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
    static var step1FinalResult: Array<Dictionary<String, Any>> = []
    static var step2FinalResult: Array<Dictionary<String, Any>> = []
    
    
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
    
    
    // MARK: Distractor Step 2
    
    static var step2AnswerKey: [String] {
        get {
            let alphabet: Array<Character> = ["A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
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
}
