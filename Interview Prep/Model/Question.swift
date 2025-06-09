//
//  Question.swift
//  Interview Prep
//
//  Created by Karl Cridland on 08/06/2025.
//

import Foundation

class Question: Codable {
    
    let id, question, answer, category: String
    let difficulty: Difficulty
    
    var understanding: Understanding
    
    init(id: String, question: String, answer: String, category: String, difficulty: Difficulty) {
        self.id = id
        self.question = question
        self.answer = answer
        self.category = category
        self.difficulty = difficulty
        self.understanding = Understanding(rawValue: UserDefaults.standard.string(forKey: "question_\(id)") ?? "") ?? .notConfident
    }
    
    func setUnderstanding(_ understanding: Understanding) {
        self.understanding = understanding
        UserDefaults.standard.set(understanding.rawValue, forKey: "question_\(self.id)")
    }
    
}
