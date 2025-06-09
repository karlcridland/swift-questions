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
    let info = ProductInformationView()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        self.addSubview([self.background, self.info])
        self.isHidden = true
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
            self.info.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.info.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.info.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ProductInformationView: UIView {
    
    let category, title, answer: UILabel
    let understanding: ProductInformationButtons
    
    init() {
        self.category = UILabel()
        self.title = UILabel()
        self.answer = UILabel()
        self.understanding = ProductInformationButtons()
        
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 24
        self.layer.cornerCurve = .continuous
        self.shadow()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.category.font = .systemFont(ofSize: 14, weight: .bold)
        self.category.numberOfLines = 1
        
        self.title.font = .systemFont(ofSize: 18, weight: .bold)
        self.title.numberOfLines = 0
        
        self.answer.font = .systemFont(ofSize: 16, weight: .regular)
        self.answer.numberOfLines = 0
        
        var previous: UIView?
        [self.category, self.title, self.answer, self.understanding].forEach { view in
            previous = self.place(view: view, previous: previous)
        }
        
    }
    
    func set(question: Question) {
        self.title.text = question.question
        
        self.category.text = "\(question.category) - \(question.difficulty.toString)"
        self.category.textColor = question.difficulty.color
        
        self.answer.text = question.answer
    }
    
    func place(view: UIView, previous: UIView?) -> UIView {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let topAnchor: NSLayoutYAxisAnchor = previous?.bottomAnchor ?? view.topAnchor
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: previous == nil || previous == self.title ? 20 : 5),
            view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
        ])
        return view
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.category.topAnchor, constant: -20),
            self.bottomAnchor.constraint(equalTo: self.understanding.bottomAnchor, constant: 10),
            self.understanding.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ProductInformationButtons: UIView {
    
    var onClick: ((Understanding) -> Void)?
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        var previous: UnderstandingButton?
        Understanding.allCases.sorted(by: {$0.sort < $1.sort}).forEach { understanding in
            let button = UnderstandingButton(understanding)
            button.addTarget(self, action: #selector(self.clicked), for: .touchUpInside)
            previous = self.set(button: button, previous: previous)
        }
    }
    
    func set(button: UnderstandingButton, previous: UIView?) -> UnderstandingButton {
        self.addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: previous?.trailingAnchor ?? self.leadingAnchor),
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: CGFloat(1) / CGFloat(Understanding.allCases.count))
        ])
        return button
    }
    
    @objc func clicked(sender: UnderstandingButton) {
        self.onClick?(sender.understanding)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class UnderstandingButton: UIButton {
    
    let understanding: Understanding
    
    init(_ understanding: Understanding) {
        self.understanding = understanding
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setImage(understanding.image(), for: .normal)
        self.setImage(understanding.image(true), for: .highlighted)
        self.tintColor = understanding.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
