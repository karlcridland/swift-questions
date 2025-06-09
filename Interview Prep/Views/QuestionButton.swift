//
//  QuestionButton.swift
//  Interview Prep
//
//  Created by Karl Cridland on 08/06/2025.
//

import UIKit

class QuestionButton: UIButton {
    
    private let question: Question
    
    let category: UILabel = UILabel()
    let title: UILabel = UILabel()
    let understanding: UIImageView = UIImageView()
    
    var onUpdate: ((Understanding) -> Void)?
    var onClicked: ((Question) -> Void)?
    
    init(_ question: Question) {
        self.question = question
        super.init(frame: .zero)
        
        self.title.text = question.question
        self.title.numberOfLines = 0
        self.title.font = .systemFont(ofSize: 16, weight: .semibold)
        
        self.category.text = "\(question.category) - \(question.difficulty.toString)"
        self.category.numberOfLines = 1
        self.category.font = .systemFont(ofSize: 14, weight: .bold)
        self.category.textColor = question.difficulty.color

        self.update(with: question.understanding)
        
        self.addSubview([self.category, self.title, self.understanding])
        self.translatesAutoresizingMaskIntoConstraints = false
        
        [self.category, self.title, self.understanding].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            view.isUserInteractionEnabled = false
        }
        
        self.understanding.layer.cornerRadius = 1.5
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        self.layer.cornerCurve = .continuous
        
        self.shadow()
        
        self.understanding.contentMode = .center
        
        self.addTarget(self, action: #selector(self.clicked), for: .touchUpInside)
        
    }
    
    @objc func clicked() {
        self.onClicked?(self.question)
    }
    
    func update(with understanding: Understanding) {
        self.understanding.tintColor = understanding.color
        self.understanding.image = understanding.image()
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            self.category.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            self.category.leftAnchor.constraint(equalTo: self.leftAnchor, constant: padding),
            
            self.title.topAnchor.constraint(equalTo: self.category.bottomAnchor, constant: 5),
            self.title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: padding),
            self.title.rightAnchor.constraint(equalTo: self.understanding.leftAnchor, constant: -padding),
            
            self.understanding.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -padding),
            self.understanding.widthAnchor.constraint(equalToConstant: 40),
            self.understanding.heightAnchor.constraint(equalToConstant: 40),
            self.understanding.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.bottomAnchor.constraint(equalTo: self.title.bottomAnchor, constant: padding),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
