//
//  QuestionScrollView.swift
//  Interview Prep
//
//  Created by Karl Cridland on 08/06/2025.
//

import UIKit

class QuestionScrollView: UIScrollView {
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        self.clipsToBounds = false
    }
    
    func setButtons(_ questions: [Question]) -> [QuestionButton] {
        self.removeAllSubviews()
        var previous: QuestionButton?
        var buttons: [QuestionButton] = []
        questions.forEach { question in
            let button: QuestionButton = QuestionButton(question)
            buttons.append(button)
            previous = self.display(button, previous)
            button.onUpdate = { understanding in
                question.setUnderstanding(understanding)
            }
        }
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
            self.contentSize.height = previous?.frame.maxY ?? 0 + 12
        }
        return buttons
    }
    
    func display(_ button: QuestionButton, _ previous: UIView?) -> QuestionButton {
        self.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: previous?.bottomAnchor ?? self.topAnchor, constant: 12),
            button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 24)
        ])
        return button
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIView {
    
    func removeAllSubviews() {
        self.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    func addSubview(_ views: [UIView]) {
        views.forEach { view in
            self.addSubview(view)
        }
    }
    
    func shadow(color: UIColor = .black) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 0.15
        self.layer.shadowRadius = 10
        self.layer.masksToBounds = false
    }
    
}
