//
//  QuestionModel.swift
//  Interview Prep
//
//  Created by Karl Cridland on 08/06/2025.
//

import Foundation

class QuestionsModel {
    
    var questions: [Question] = []
    var cached_questions: [Question] = []
    
    var onUpdate: (() -> Void)?
    var onSearch: ((String) -> Void)?
    
    let status: Status = Status()
    
    var category_filter: [String] = ["Accessibility", "Data", "Design Patterns", "Frameworks", "Miscellaneous", "Performance", "Security", "Swift", "UIKit", "iOS"]
    
    let view: QuestionView = QuestionView()
    
    init() {
        self.view.info.understanding.onClick = { understanding in
            if let question = self.view.current {
                question.setUnderstanding(understanding)
                self.view.hide()
                self.sort()
                self.onUpdate?()
            }
        }
    }
    
    func get() {
        if let url = Bundle.main.url(forResource: "questions", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            do {
                self.cached_questions = try self.loadQuestions(from: data)
//                let categories = Array(Set(self.cached_questions.compactMap({$0.category})))
//                print(categories.sorted())
                self.sort()
                self.onUpdate?()
            } catch {
                print("Failed to load questions: \(error)")
            }
        }
    }
    
    func loadQuestions(from data: Data) throws -> [Question] {
        let raw = try JSONDecoder().decode([String: QuestionData].self, from: data)
        return raw.map { (key, value) in
            Question(id: key, question: value.question, answer: value.answer, category: value.category, difficulty: Difficulty(rawValue: value.difficulty) ?? .easy)
        }
    }
    
    func sort() {
        var results = self.cached_questions
            .sorted(by: {$0.difficulty.rawValue < $1.difficulty.rawValue})
            .sorted(by: {$0.understanding.sort > $1.understanding.sort})
        if (!self.category_filter.isEmpty) {
            results = results.filter({self.category_filter.contains($0.category)})
        }
        self.questions = results
        self.status.update(self.questions)
    }
    
}

