//
//  QuestionInformationButtons.swift
//  Interview Prep
//
//  Created by Karl Cridland on 09/06/2025.
//

import UIKit

class QuestionInformationButtons: UIView {
    
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
