//
//  QuestionView.swift
//  Interview Prep
//
//  Created by Karl Cridland on 08/06/2025.
//

import UIKit

class QuestionView: UIView {
    
    var current: Question?
    
    private let background = BackgroundView()
    let info = QuestionInformationView()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        self.addSubview([self.background, self.info])
        self.isHidden = true
        self.info.addTarget(self, action: #selector(self.hide), for: .touchUpInside)
        self.background.addTarget(self, action: #selector(self.hide), for: .touchUpInside)
    }
    
    func display(_ question: Question) {
        self.current = question
        self.info.set(question: question)
        self.isHidden = false
        self.info.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.info.alpha = 1
            self.background.set(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        }
    }
    
    @objc func hide() {
        self.info.alpha = 1
        UIView.animate(withDuration: 0.3) {
            self.info.alpha = 0
            self.background.set(effect: nil)
        } completion: { _ in
            self.isHidden = true
        }
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        NSLayoutConstraint.activate([
            self.info.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -35),
            self.info.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.info.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
