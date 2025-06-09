//
//  UnderstandingButton.swift
//  Interview Prep
//
//  Created by Karl Cridland on 09/06/2025.
//

import UIKit

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
