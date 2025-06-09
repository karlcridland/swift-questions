//
//  BackgroundView.swift
//  Interview Prep
//
//  Created by Karl Cridland on 08/06/2025.
//

import UIKit

class BackgroundView: UIButton {
    
    private let blur: UIVisualEffectView = UIVisualEffectView()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        self.blur.frame = self.bounds
        self.addSubview(self.blur)
        self.blur.isUserInteractionEnabled = false
    }
    
    func set(effect: UIBlurEffect?) {
        self.blur.effect = effect
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
