//
//  StatusView.swift
//  Interview Prep
//
//  Created by Karl Cridland on 09/06/2025.
//

import UIKit

class StatusView: UIView {
    
    let understanding: Understanding
    
    let icon: UIImageView = UIImageView()
    let label: UILabel = UILabel()
    
    init(_ understanding: Understanding) {
        self.understanding = understanding
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = understanding.color
        
        self.icon.image = understanding.image(true)
        self.icon.tintColor = .white
        self.icon.contentMode = .center
        
        self.label.font = .systemFont(ofSize: 14, weight: .black)
        self.label.textColor = .white
        
        [self.icon, self.label].forEach { view in
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.transform = CGAffineTransform(translationX: 5, y: 0)
            NSLayoutConstraint.activate([
                view.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            ])
        }
        NSLayoutConstraint.activate([
            self.icon.rightAnchor.constraint(equalTo: self.centerXAnchor),
            self.label.leftAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

